#!/usr/bin/env python3

"""Unpack a MIME message into a directory of files."""

import os
import sys
import email
import mimetypes

from email.policy import default

from argparse import ArgumentParser


def main():
	parser = ArgumentParser(description="""\
Unpack a MIME message into a directory of files.
""")
	parser.add_argument('-d', '--directory', required=True,
						help="""Unpack the MIME message into the named
						directory, which will be created if it doesn't already
						exist.""")
	parser.add_argument('msgfile')
	args = parser.parse_args()

	if args.msgfile == '-':
		msg = email.message_from_file(sys.stdin, policy=default)
	else:
		with open(args.msgfile, 'rb') as fp:
			msg = email.message_from_binary_file(fp, policy=default)
	try:
		os.mkdir(args.directory)
	except FileExistsError:
		pass

	counter = 1
	for part in msg.walk():
		# multipart/* are just containers
		if part.get_content_maintype() == 'multipart':
			continue
		# Applications should really sanitize the given filename so that an
		# email message can't be used to overwrite important files
		filename = part.get_filename()
		if filename:
			filename = os.path.basename(filename)
		if not filename:
			ext = mimetypes.guess_extension(part.get_content_type())
			if not ext:
				# Use a generic bag-of-bits extension
				ext = '.bin'
			filename = f'part-{counter:03d}{ext}'
		counter += 1
		destination = os.path.join(args.directory, filename)
		if os.path.exists(destination):
			print(f'File {destination} exists yet.')
		else:
			with open(os.path.join(args.directory, filename), 'wb') as fp:
				fp.write(part.get_payload(decode=True))
				print(f'Creating {destination}.')



if __name__ == '__main__':
	main()
