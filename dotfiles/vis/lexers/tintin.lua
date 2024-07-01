-- Copyright 2022-2024 Mitchell. See LICENSE.
-- ? LPeg lexer.
-- https://orbitalquark.github.io/scintillua/api.html


local lexer = lexer
local P, S = lpeg.P, lpeg.S

local lex = lexer.new(...)

-- Keywords.
lex:add_rule('keyword', lexer.token(lexer.KEYWORD, '#' * lexer.word_match{
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
	'unticker', 'var', 'variable', 'while', 'write', 'zap'
}))

-- Identifiers.
lex:add_rule('identifier', lex:tag(lexer.IDENTIFIER, lexer.word))

-- Comments.
lex:add_rule('comment', lex:tag(lexer.COMMENT, lexer.to_eol('#nop')))

-- Numbers.
lex:add_rule('number', lex:tag(lexer.NUMBER, lexer.number))

-- Operators.
lex:add_rule('operator', lex:tag(lexer.OPERATOR, S('+-*/%^=<>,.{}[]()')))

-- Variables
lex:add_rule('variable', lex:tag(lexer.VARIABLE, '$' * (lexer.number + lexer.word)) )

-- Strings.
local sq_str = lexer.range("'")
local dq_str = lexer.range('"')
lex:add_rule('string', lex:tag(lexer.STRING, sq_str + dq_str))

-- Fold points.
--lex:add_fold_point(lexer.KEYWORD, 'start', 'end')
lex:add_fold_point(lexer.OPERATOR, '{', '}')


return lex
