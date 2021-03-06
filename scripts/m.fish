#! /usr/bin/fish
# neatmail wrapper

set BINDIR $HOME/.local/bin
set POP3 $BINDIR/pop3
set NEATMAIL $BINDIR/neatmail				# neatmail address
set BROWSER firefox
set SEND $BINDIR/smtp				# neatmail smtp
set UNMIME $BINDIR/unmime.py			# ripmime, unmime.py
set MKMIME $BINDIR/mkmime.py			# mimer.py
set MAILDIR $HOME/var/mail
set LIST $MAILDIR/list.nm			# listing file
set MSG $MAILDIR/cur.eml			# current message
set DRAFT $MAILDIR/draft.eml		# current draft
set OLD $MAILDIR/old.eml			# old draft
set INBOX $MAILDIR/box/inbox		# incoming boxes
set SENT $MAILDIR/box/sent			# record for sent mails
set BOX $MAILDIR/box/inbox
set MFMT "-0 18from:48~subject:"	# listing format
set VFMT "-0 18from:20date:48~subject:"	# verbose listing format
set HDRS "from:subject:to:cc:date:user-agent:x-mailer:organization:status:"
set HDRSFWD $HDRS"mime-version:content-type:content-transfer-encoding:"
set FROMESC "2,\$s/^From />From /"
set COLORSET "s/^\(N[^\t]*\)/[1;32m\1[0;0m/g; s/^\(I[^\t]*\)/[1;33m\1[0;0m/g"

set FROM (cat $MAILDIR/.from)
set FROMSET "s/^From: \$/From: $FROM/; /^Message-ID:/s/neatmail.host/localhost.localdomain/"
set BOX (cat $MAILDIR/.box)
#set CUR (cat $MAILDIR/.cur | sed -e "s/\(....\).*/\1/g")
set CUR (cat $MAILDIR/.cur)
set BOXES (ls $MAILDIR/box)
set CMD $argv[1]

# Fetch messages
if test "$CMD" = "pop"
	eval $POP3
	exit
end

# list new messages
if test "$CMD" = "inc"
	eval $NEATMAIL ns $BOXES
	exit
end

# execute commands in listing
if test "$CMD" = "com"
	cp $BOX /tmp/.neatmail.(echo $BOX | tr / .)
	begin cat $LIST; and echo ":w"; end | eval $NEATMAIL ex $BOX || exit 1
	set CMD box
end


# create the listing for an mbox
if test "$CMD" = "box"
	if test -n "$argv[2]"
		echo $MAILDIR/box/$argv[2] > $MAILDIR/.box
		set BOX $MAILDIR/box/$argv[2]
		if test "$argv[2]" = "inbox" -o "$argv[2]" = "groff"
			echo "@inbox@" > $MAILDIR/.from
		else if test "$argv[2]" = "fanuilas"
			echo "@fanuilas@" > $MAILDIR/.from
		else if test "$argv[2]" = "laposte"
			echo "@laposte@" > $MAILDIR/.from
		else if test "$argv[2]" = "scic"
			echo "@scic@" > $MAILDIR/.from
		else if test "$argv[2]" = "csmjc" -o "$argv[2]" = "fede"
			echo "@csmjc@" > $MAILDIR/.from
		end
	end
	# -st sort by thread, -sd sort by date
	eval $NEATMAIL mk -r $MFMT $BOX | sed -e "/^O/d" >$LIST
	sed "$COLORSET" $LIST
	exit
end

# create the listing for an mbox, sorted by thread
if test "$CMD" = "thread"
	if test -n "$argv[2]"
		echo $MAILDIR/box/$argv[2] > $MAILDIR/.box
		set BOX $MAILDIR/box/$argv[2]
	end
	# -st sort by thread, -sd sort by date
	eval $NEATMAIL mk -r -st $MFMT $BOX | sed -e "/^O/d" >$LIST
	sed "$COLORSET" $LIST
	exit
end

# Make a verbose listing of the current mbox
if test "$CMD" = "ver"
	#$NEATMAIL mk -st -0 from:subject: -1 ~date:to:cc: $BOX >$LIST
	eval $NEATMAIL mk $VFMT $BOX >$LIST
	sed "$COLORSET" $LIST
	exit
end

# List mails starting at $argv[2]
if test "$CMD" = "from"
	eval $NEATMAIL mk $MFMT -f $argv[2] $BOX >$LIST
	exit
end

# Open the listing in an editor
if test "$CMD" = "list"
	eval $EDITOR $LIST
	exit
end

# Open the listing in an editor
if test "$CMD" = "ls"
	sed "$COLORSET" $LIST
	exit
end

# show the next message
if test "$CMD" = "next"
	set NUM (sed -n "/.0*$CUR/{n; s/.0*\([^\t]*\).*/\1/;p}" $LIST)
	echo "$CUR -> $NUM"
	# prefix number with 0
	# set NUMBER (printf "%04d" $CUR)
	# get next line
	# set NUM (awk "/^.$NUMBER/ {getline; print substr(\$1, 3)}" $LIST)
	if test "$NUM" = "$CUR"
		echo "No more messages."
		exit
	end
	echo $NUM > $MAILDIR/.cur
	set CUR $NUM
	set CMD vi
end

# show the previous message
if test "$CMD" = "prev"
	set NUMBER (printf "%04d" $CUR)
	# get previous line
	set NUM (awk "/^.$NUMBER/ {print prev} {prev = substr(\$1, 3)}" $LIST)
	if test "$NUM" = "$CUR"
		echo "No previous messages."
		exit
	end
	echo $NUM > $MAILDIR/.cur
	set CUR $NUM
	set CMD vi
end

# page mail $argv[2]
if test "$CMD" = "vi"
	if test -n "$argv[2]"
		echo $argv[2]> $MAILDIR/.cur
		set CUR $argv[2]
	end
	set NUMBER (printf "%04d" $CUR)
	#sed -n "/^.$NUMBER/p" $LIST
	eval $NEATMAIL pg -m -h $HDRS $BOX $CUR > $MSG
	eval $EDITOR $MSG
	set CMD R
end

# output raw message $argv[2]
if test "$CMD" = "raw"
	if test -n "$argv[2]"
		echo $argv[2]> $MAILDIR/.cur
		set CUR $argv[2]
	end
	eval $NEATMAIL pg $BOX $CUR
	exit
end

# decode a mime message
if test "$CMD" = "mime"
	if test -n "$argv[2]"
		echo $argv[2] > $MAILDIR/.cur
		set CUR $argv[2]
	end
	set -l MIMEDIR $MAILDIR/tmp/$CUR
	echo Exploding in $MIMEDIR.
	eval $NEATMAIL pg $BOX $CUR | $UNMIME -d $MIMEDIR -
	exit
end

# open an html file in firefox
if test "$CMD" = "fox"
	eval $BROWSER $MAILDIR/tmp/$CUR/*.html
	exit
end

# Mark a message
# Answered, Delete, Important, Mark, New, Old, Read
for letter in A D I M N O R
	if test "$CMD" = "$letter"
		if test -n "$argv[2]"
			echo $argv[2] > $MAILDIR/.cur
			set CUR $argv[2]
		end
		set NUMBER (printf "%04d" $CUR)
		sed -i "s/^.$NUMBER/$CMD$NUMBER/" $LIST
		sed -n "/^$CMD$NUMBER/p" $LIST
		exit
	end
end

# mv a message
if test "$CMD" = "mv"
	if test -n "$argv[2]"
		echo "mv $CUR box/$argv[2]"
		begin echo :"$CUR"mv box/"$argv[2]" ; and echo ":w"; end | eval $NEATMAIL ex $BOX || exit 1
	else
		echo "mv $CUR where?"
	end
	exit
end

# edit a new mail
if test "$CMD" = "draft"
	if test -f $DRAFT
		eval $EDITOR $DRAFT
	else
 		echo "No draft <$DRAFT>"
		exit 1
	end
	exit
end 
	
# write a new mail
if test "$CMD" = "new"
	test -f $DRAFT; and echo "Unposted draft <$DRAFT>"; and exit 1
	if test -n "$argv[2]"
		set -l destlist $argv[2..-1]
		echo $destlist
		eval $NEATMAIL pg -n | sed "$FROMSET" | sed "s/To: /To: $destlist/" > $DRAFT
	else
		eval $NEATMAIL pg -n | sed "$FROMSET" >$DRAFT
	end
	eval $EDITOR $DRAFT
	exit
end


# reply to a mail
if test "$CMD" = "repl"
	if test -n "$argv[2]"
		echo $argv[2]> $MAILDIR/.cur
		set CUR $argv[2]
	end
	test -f $DRAFT; and echo "Unposted draft <$DRAFT>"; and exit 1
	eval $NEATMAIL pg -r -m $BOX $CUR | sed "$FROMSET" >$DRAFT
	eval $EDITOR $DRAFT
	exit
end

# forward a mail
if test "$CMD" = "forw" -o "$CMD" = "forward"
	if test -n "$argv[2]"
		echo $argv[2]> $MAILDIR/.cur
		set CUR $argv[2]
	end
	test -f $DRAFT; and echo "Unposted draft <$DRAFT>"; and exit 1
	eval $NEATMAIL pg -f -m -h $HDRSFWD $BOX $CUR | sed "$FROMSET" >$DRAFT
	eval $EDITOR $DRAFT
	exit
end

# add an attachment
if test "$CMD" = "add" -o "$CMD" = "attach"
	if test -z "$argv[2]"
		echo "Which file should be attached?"
		exit
	end
	eval $MKMIME $DRAFT (string escape $argv[2]); and exit
	echo "Could'nt add $argv[2]"
	exit 1
end

# convert draft to utf8
if test "$CMD" = "uconv"
	cp $DRAFT $OLD
	uconv -f iso8859-1 -t utf8 $OLD > $DRAFT
	exit
end

# send a message
if test "$CMD" = "send"
	test -f $DRAFT; or begin
		echo "draft <$DRAFT> missing"
		exit 1
	end
	cp $DRAFT $OLD
	eval $MKMIME $DRAFT; or begin
		echo "Can't format <$DRAFT>. Not sent."
		exit 1
	end
	#cat $DRAFT | sed "$FROMESC" | $SEND || (echo "<$DRAFT> not sent."; exit 1)
	tail -n+2 $DRAFT | sed "$FROMESC" | $SEND
	set _status $status
	if test $_status -eq  0
		begin
			cat $DRAFT
			echo
		end | sed "$FROMESC" >> $SENT
		#(cat $DRAFT && echo) | sed "$FROMESC" >>$INBOX
		rm $DRAFT
		exit
	else 
		echo "<$DRAFT> not sent."
		exit $_status
	end
end

# help
if test "$CMD" = "h" -o "$CMD" = "help"
	echo "neatmail ex commands summary:

rm     remove the current message.
cp     copy the current message to the given mbox.
mv     move the current message to the given mbox.
hd     change the value of the given header of the current message.
ft     filter the message through the given command.
w      write the mbox.
g, g!  ex-like global command.
tj     join threads by modifying Reply-To headers.
ch     chop the message at the specified offset.

examples:
2,5rm              remove message 2 through 5.
/pattern/rm        remove message with pattern in subject
/^field: value/rm  remove message whith value in field"
	exit
end

if test -n "$CMD"
	echo "Unknown command: <$CMD>"
end

echo "
m pop         fetch messages
m inc         check mboxes for new mails
m com         execute commands in $LIST
m help        show the list of commands
m box mbox    list messages in the mbox
m scic        list the scic mbox
m inbox       list the inbox mbox
m ver         verbose list of messages
m from msg    list messages starting from msg
m list        open the listing in an editor
m ls          page the listing
m vi msg     page message msg
m raw msg     display the raw msg
m mime msg     base64 decode the msg
m A|D|M|O|R|N   mark the current message
  Answered, Delete, Mark, Old, Read, N
m next        show the next mail
m prev        show the previous mail
m draft       edit the current draft
m new         write a new mail
m repl msg     write a reply to msg
m forw msg     forward msg
m add file    attach file to the draft
m send        send the current draft

"
exit 1
