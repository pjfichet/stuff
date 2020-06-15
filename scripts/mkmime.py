#! /usr/bin/env python

import sys
from os import path
from mimetypes import guess_type
from email.parser import BytesParser
from email.generator import Generator
from email.policy import default

# Get the filename of the draft
if len(sys.argv) == 1:
    print("Which draft should be formatted?")
    sys.exit(0)
draft = sys.argv[1]

# Load the draft
with open(draft, 'rb') as fi:
    mail = BytesParser(policy=default).parse(fi)

# Add mime headers
if 'Mime-Version' not in mail:
    mail.add_header('Mime-Version', '1.0')
    #mail.add_header('Content-Type', 'text-plain')
    mail.set_param('charset', 'utf-8')
    mail.add_header('Content-Transfer-Encoding', 'quoted-printable')

# Rewrite some fields
fields = ( 'to', 'cc', 'bcc', 'subject')
for field in fields:
    if field in mail:
        value = mail[field]
        #mail.replace_header(field.capitalize(), value)
        del mail[field]
        mail.add_header(field.capitalize(), value)

# Add the potential attachment
if len(sys.argv) == 3:
    pathname = sys.argv[2]
    filename = path.basename(sys.argv[2])
    try:
        mimetype, subtype = guess_type(pathname)[0].split('/')
	except AttributeError:
        mimetype, subtype = application, unknown
    with open(pathname, 'rb') as attachment:
        data = attachment.read()
        mail.add_attachment(data, mimetype, subtype, filename=filename)

# Rewrite the file
with open(draft, 'w') as fo:
    gen = Generator(fo)
    gen.flatten(mail, unixfrom=True)

