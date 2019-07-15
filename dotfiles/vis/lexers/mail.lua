-- Copyright 2018 pierrejean.fichet at posteo.net. See LICENSE.
-- Mail LPeg lexer.

local l = require('lexer')
local token, word_match = l.token, l.word_match
local P, R, S = lpeg.P, lpeg.R, lpeg.S

local M = {_NAME = 'mail'}

-- Field.
local from = token(l.KEYWORD, l.starts_line(P('From ') * l.nonnewline^0))
local field_name = P(l.ascii) - P(':') - P(l.space)
local field = token(l.KEYWORD, l.starts_line(field_name^1 * P(':')))

-- Mail address.
local address_char = P(l.alnum) + P('_') + P('.') + P('-') + P('=') + P('+') + P('/')
local address = token(l.STRING, address_char^1 * P('@') * address_char^1)

-- Url.
local url_char = P(l.alnum) + P('_') + P('.') + P('-') + P('/')
local url_protocol = P(word_match(
	{'http', 'https', 'ftp', 'gopher', 'git'}
	)) * P('://')
local url_action = P(word_match(
	{'mailto', 'file', 'news'}
	)) * P(':')
local url = token(l.STRING, P(url_protocol + url_action)^1 * url_char^1)

-- Quotation.
local quotation = token(l.COMMENT, l.starts_line(l.space^0 * P('>')) * l.nonnewline^0)


M._rules = {
  {'from', from},
  {'field', field},
  {'address', address},
  {'url', url},
  {'quotation', quotation},
}

return M
