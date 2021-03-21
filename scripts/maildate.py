# /usr/bin/env python

import os
from email.parser import BytesParser
from email.policy import default
import time
from datetime import datetime
from email.utils import parsedate

mbox = "/home/pj/mails/mdir/Anciens/cur"

for filename in os.listdir(mbox):
	path = os.path.join(mbox, filename)
	if not os.path.isfile(path):
		continue
	with open(path, 'rb') as fi:
		mail = BytesParser(policy=default).parse(fi)
		date = parsedate(mail['Date'])
		#print(date)
		datetime = time.mktime(date)
		#print(filename, datetime)
		os.utime(path, (datetime, datetime))
