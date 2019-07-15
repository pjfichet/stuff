-- Copyright 2006-2017 Mitchell mitchell.att.foicica.com. See LICENSE.
-- Tintin++ LPeg lexer.

local l = require('lexer')
local token, word_match = l.token, l.word_match
local P, R, S = lpeg.P, lpeg.R, lpeg.S

local M = {_NAME = 'tintin'}

-- Whitespace.
local ws = token(l.WHITESPACE, l.space^1)

-- Comments.
local comment = token(l.COMMENT, '#nop' * l.nonnewline^0)

-- Strings.
--local sq_str = l.delimited_range("'", true, true)
local dq_str = l.delimited_range('"', true, true)

local string = token(l.STRING, dq_str)

-- Numbers.
local number = token(l.NUMBER, l.float + l.integer)

-- Keywords.
local keyword_name = word_match({
	'act', 'action', 'alias', 'all', 'bell', 'break', 'buffer',
	'case', 'chat', 'class', 'config', 'continue',
	'cr', 'cursor', 'debug', 'default', 'delay', 'echo',
	'else', 'elseif', 'end', 'event', 'forall', 'foreach',
	'format', 'function', 'gag', 'ungag', 'greeting', 'grep',
	'help', 'high', 'highlight', 'history', 'if', 'ignore', 'info',
	'kill', 'line', 'list', 'local', 'log', 'loop', 'macro',
	'map', 'math', 'message', 'parse', 'path', 'pathdir',
	'port', 'prompt', 'read', 'regexp', 'replace', 'return', 'run',
	'scan', 'script', 'send', 'session', 'showme', 'snoop',
	'speedwalk', 'split', 'ssl', 'sub', 'substitute',
	'suspend', 'switch', 'system', 'tab', 'textin', 'ticker',
	'unticker', 'var', 'variable', 'while', 'write', 'zap',
}, nil, true)
local keyword = token(l.KEYWORD, P('#') * P(keyword_name))

-- Identifiers.
--local identifier =token(l.IDENTIFIER,  P('{') * P(l.word) * P('}') )

-- Variables.
local variable = token(l.VARIABLE,
                       '$' * (S('!#?*@$') + l.digit^1 + l.word +
                              l.delimited_range('{}', true, true, true)))

-- Colors
local color = token(l.CONSTANT, '<' * P(l.alnum)^-3 * '>')

-- Operators.
local operator = token(l.OPERATOR, S('=!<>+-/*^&|~.,:;?()[]{}'))

M._rules = {
  {'whitespace', ws},
  {'keyword', keyword},
  --{'identifier', identifier},
  {'string', string},
  {'comment', comment},
  {'number', number},
  {'variable', variable},
  {'color', color},
  {'operator', operator},
}

M._foldsymbols = {
  _patterns = {'[a-z]+', '[{}]', '#'},
  [l.KEYWORD] = {
    ['if'] = 1, fi = -1, case = 1, esac = -1, ['do'] = 1, done = -1
  },
  [l.OPERATOR] = {['{'] = 1, ['}'] = -1},
  [l.COMMENT] = {['#'] = l.fold_line_comments('#')}
}

return M
