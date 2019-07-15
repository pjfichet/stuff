-- Copyright 2015-2017 David B. Lamkins <david@lamkins.net>. See LICENSE.
-- pacman.log LPeg lexer.

local l = require('lexer')
local token, word_match = l.token, l.word_match
local P, R, S = lpeg.P, lpeg.R, lpeg.S

local M = {_NAME = 'pacman'}

-- Warning.
local pacman_warning = P('warning') * l.nonnewline^0
local pacman_warning2 = P('WARNING') * l.nonnewline^0
local warning = token(l.ERROR, pacman_warning + pacman_warning2)

local pacman_installed = P('installed')
local installed = token(l.KEYWORD, pacman_installed)

local pacman_removed = P('removed')
local removed = token(l.STRING, pacman_removed)

local pacman_command = P('[PACMAN]') * l.nonnewline^0
local pacman_scriptlet = P('[ALPM-SCRIPTLET]')
local command = token(l.PREPROCESSOR, pacman_command + pacman_scriptlet)

M._rules = {
  --{'whitespace', ws},
  {'warning', warning},
  {'installed', installed},
  {'removed', removed},
  {'command', command},
}

return M
