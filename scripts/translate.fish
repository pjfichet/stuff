#! /usr/bin/fish

set TMPFILE /tmp/file.html
set TR (basename (status -f))

wget --quiet --user-agent=mozilla -O $TMPFILE "http://www.wordreference.com/$TR/$argv"

grep "id='$TR" $TMPFILE | \
sed -e "
s,^<tr.*<td.*<strong>\([^<]*\).*</strong>.*</td><td>.*(\([^)]*\)).*</td><td class='ToWrd' >\([^<]*\).*<em.*,\1 (\2): \3,g
s,.*<strong>\([^<]*\)</strong>.*<td class='ToWrd' >\([^<]*\)<em.*,\1: \2,g
s,<i>,,g
s,</i>,,g
s,<span title='[^']*'>,,g
s,</span>,,g
s,\[,,g
s,\],,g
s, *\$,,g
s,\$,.,g
/<tr.*/d"

rm $TMPFILE