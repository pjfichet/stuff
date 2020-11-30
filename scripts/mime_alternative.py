#! /usr/bin/env/python

# This file creates an alternative mime message, ie a mime message containing
# an html file and a plain text alternative. Related files or attachment can be
# attached to this alternative mime message. Thus, in the end, a multipart mime
# message is created, containing attachments, related messages, and alternative
# message with the following hierarchy:
#
# multipart mime
#   related mime
#       alternative mime
#           html file
#           plain text file
#       related file
#       related file
#       ...
#   attachment
#   attachment
#   ...
#   
# From the command line, one must specify from field, to field, subject field
# html file, and plain text file. Related files and attachment are optionals.
#
# The resulting mime message is printed to stdout.
#
# A nice tutorial about mime messages in python:
# https://www.anomaly.net.au/blog/constructing-multipart-mime-messages-for-sending-emails-in-python/
#
# Unfortunately, this script uses the legacy email.mime api. It should be
# re-written using the newer contentmanager api:
# https://docs.python.org/3/library/email.contentmanager.html#module-email.contentmanager
# Python documentation for email is here:
# https://docs.python.org/3/library/email.html

import sys
  
import argparse
parser = argparse.ArgumentParser()
parser.add_argument("-f", "--fromfield", help="email From field", required=True)
parser.add_argument("-t", "--to", help="email To field", required=True)
parser.add_argument("-s", "--subject", help="email Subject field", required=True)
parser.add_argument("-p", "--plain", help="plain text file", required=True)
parser.add_argument("-m", "--html", help="html file", required=True)
parser.add_argument("-r", "--related", help="related file", nargs='*')
parser.add_argument("-a", "--attachment", help="attachment", nargs='*')
args = parser.parse_args()

from email.mime.multipart import MIMEMultipart
multipart_message = MIMEMultipart()
multipart_message["subject"] = args.subject
multipart_message["from"] = args.fromfield
multipart_message["Bcc"] =  args.fromfield
multipart_message["To"] = args.to
# multipart_message["To"] = "Georges Bray <georges.bray@centres-sociaux.fr>"

from email.mime.text import MIMEText
alternative_message = MIMEMultipart('alternative')
with open(args.plain, "r") as f:
    text_part = MIMEText(f.read(), 'plain')
    alternative_message.attach(text_part)
with open(args.html, "r") as f:
    html_part = MIMEText(f.read(), 'html')
    alternative_message.attach(html_part)

if args.related:
    # We create a related message
    from email.mime.image import MIMEImage
    related_message = MIMEMultipart('related')
    # attach the alternative message to the related one
    related_message.attach(alternative_message)
    # attach the document to the related message
    for filename in args.related:
        try:
            with open(filename, "rb") as f:
                image = MIMEImage(f.read())
                # link the image with <img src="cid:logo"/>
                image.add_header('Content-ID', f"<{filename}>")
        except IOError:
            print(f"{filename} not found.", file=sys.stderr)
            sys.exit(1)
        related_message.attach(image)
    # attach the related message to the multipart message
    multipart_message.attach(related_message)
else:
    # there's no related message, attach the alternative message
    # to the multipart message
    multipart_message.attach(alternative_message)

if args.attachment:
    # there are attachments
    from email.mime.application import MIMEApplication
    for filename in args.attachment:
        try:
            with open(filename, "rb") as f:
                pdf_file = MIMEApplication(f.read(), "pdf")
                pdf_file.add_header("Content-Disposition", "attachment", filename=filename)
        except IOError:
            print(f"{filename} not found.", file=sys.stderr)
            sys.exit(1)
        multipart_message.attach(pdf_file) 

print(multipart_message.as_string())
#with open(name + ".eml", "w") as f:
#    f.write(multipart_message.as_string())


