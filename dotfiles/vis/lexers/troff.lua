-- Copyright 2015-2017 David B. Lamkins <david@lamkins.net>. See LICENSE.
-- man/roff LPeg lexer.

local l = require('lexer')
local token, word_match = l.token, l.word_match
local P, R, S = lpeg.P, lpeg.R, lpeg.S

local M = {_NAME = 'troff'}

-- Whitespace.
-- local ws = token(l.WHITESPACE, l.space^1)

-- Comment.
local troff_comment = P('\\"') * l.nonnewline^0
local troff_ignore = '.ig' * (l.any  - '..')^0 * P('..')^-1
local comment = token(l.COMMENT, troff_comment + troff_ignore)


local troff_request = word_match({
    -- font and character size
    'ps', 'ss', 'cs', 'bd', 'ft', 'fp',
    -- page control
    'pl', 'bp', 'pn', 'po', 'ne', 'mk', 'rt',
    -- text filling
    'br', 'fi', 'nf', 'ad', 'na', 'ce',
    -- vertical spacing
    'vs', 'ls', 'sp', 'sv', 'os', 'ns', 'rs',
    -- line length and indenting
    'll', 'in', 'ti',
    -- macros strngs, diversion, traps
    'de', 'am', 'ds', 'as', 'rm', 'rn',
    'di', 'da', 'wh', 'ch', 'dt', 'it', 'em',
    -- number register
    'nr', 'af', 'rr',
    -- tabs, leaders and fields
    'ta', 'tc', 'lc', 'fc',
    -- conventions and characters
    'ec', 'eo', 'lg', 'ul', 'cu', 'uf',
    'cc', 'c2', 'tr',
    -- hyphenation
    'nh', 'hy', 'hc', 'hw',
    -- three part titles
    'tl', 'pc', 'lt',
    -- output line numbering
    'nm', 'nn',
    -- conditional
    'if', 'ie', 'el',
    -- environment
    'ev',
    -- insertion from standart input
    'rd', 'ex',
    -- I/O
    'so', 'nx', 'sy', 'pi', 'cf',
    -- miscellaneous
    'mc', 'tm', 'ab', 'ig', 'lf', 'pm', 'fl',
    }, nil, false)
local request = token(l.KEYWORD, l.starts_line('.' * l.space^0) * (P(troff_request) + P('.')) )

-- macros
local macro = token(l.FUNCTION, l.starts_line('.' * l.space^0) * (l.nonnewline - '\\' - l.space)^0)


-- escape sequences
local troff_escape_key = word_match({
    '\\', 'e', "'", '`', '-', '.', ' ', '0',
     '|', '^', '&', '!', '%', 'a', 'c',
     'd', 'k', 'p', 'r', 't', 'u',  '{', '}',
    'Z',
    }, nil, false)
local escape_key = token(l.PREPROC, P('\\') * P(troff_escape_key) )

local troff_escape_quote = word_match({
    'b', 'C', 'D', 'h', 'H', 'l', 'L',
    'N', 'o', 'S', 'v', 'w', 'x', 'X',
    })
local dq_str = '"' * (l.any - '"')^0 * P('"')^-1
local sq_str = "'" * (l.any - "'")^0 * P("'")^-1
local escape_apo = token(l.STRING,
    P('\\') * P(troff_escape_quote) * (dq_str + sq_str))

local br_str = '(' * P(2)
local cr_str = '[' * (l.any - ']')^0 * P(']')^-1
local escape_str = token(l.STRING,
        P('\\') * (P('*') + 'f' + 'g' + 'n')
        * ( br_str + cr_str + P(1) )
    )

local escape_int = token(l.STRING, (P('\\') * (P('$') + 's' + 'z') * l.digit^1 ))



M._rules = {
  --{'whitespace', ws},
  {'comment', comment},
  {'request', request},
  {'macro', macro},
  {'escape_key', escape_key},
  {'escape_apo', escape_apo},
  {'escape_str', escape_str},
  {'escape_int', escape_int},
}

return M
