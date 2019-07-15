mimeheader () {
    # Add mime header
    while read line; do
		if test "$line" = "" -a "$blank" = ""; then
			echo "Mime-version: 1.0"
			echo "Content-type: text-plain; charset=utf-8"
			echo "Content-Transfer-Encoding: quoted-printable"
			blank="done"
		 fi
		 echo $line
	done
}


	mimetype=$(xdg-mime query filetype $2)
	filename=$(basename $2)
	boundary=$(sed -n -e "s/^.*boundary=\(.*\)$/\1/p" $DRAFT)
	tmpfile=/tmp/draft.$USER.eml
	mv $DRAFT $tmpfile
	if test "$boundary" == ""; then
		boundary="oooOOOOOOOOOOOOOOOooo"
		while read line; do
			if test "$line" = "" -a "$blank" = ""; then
				echo "Content-type: multipart/mixed; boundary=$boundary"
				echo "Mime-version: 1.0"
				echo ""
				echo "--$boundary"
				echo "Content-Type: text/plain; charset=utf-8"
				echo "Content-Transfer-Encoding: quoted-printable"
				blank="done"
			 fi
			 echo $line
		done < $tmpfile > $DRAFT
	else
		cat $tmpfile > $DRAFT
	fi
	echo "" >> $DRAFT
	echo "--$boundary" >> $DRAFT
	echo "Content-Type: $mimetype; name=$filename" >> $DRAFT
	echo "Content-Type: $mimetype; name=$filename"
	echo "Content-transfer-encoding: base64" >> $DRAFT
	echo "" >> $DRAFT
	base64 $2 >> $DRAFT
	echo "" >> $DRAFT
	echo "--$boundary" >> $DRAFT
