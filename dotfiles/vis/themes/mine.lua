-- Solarized color codes Copyright (c) 2011 Ethan Schoonover
local lexers = vis.lexers

local colors = {
	bg_dark  = '#282C34', -- background
	bg_light  = '#3C414F', -- line cursor bg
	fg_dark  = '#5C6370', -- comment whitespace eof fg
	fg_normal   = '#abb2bf', -- foreground
	fg_light   = '#ffffff', -- status focused bg
	col_class  = '#D099FF', -- class, type
	col_preproc  = '#D19A66', -- preprocessor
	col_error     = '#BE5046', -- error, tag
	col_embedded = '#98c379', -- embedded
	col_regex  = '#88BFFF', -- regex
	col_function    = '#c678dd', -- function, variable, embedded
	col_string    = '#56B6C2', -- constant, number, string
	col_keyword   = '#61afef', -- keyword, label, operator
	brown   = '#brown',
	light_blue = '#88BFFF',
	beige = '#beige'
}

lexers.colors = colors
-- dark
local fg = ',fore:'..colors.fg_normal..','
local bg = ',back:'..colors.bg_dark..','

lexers.STYLE_DEFAULT = bg..fg
lexers.STYLE_NOTHING = bg
lexers.STYLE_CLASS = 'fore:col_class'
lexers.STYLE_COMMENT = 'fore:'..colors.fg_dark
lexers.STYLE_CONSTANT = 'fore:'..colors.col_string
lexers.STYLE_DEFINITION = 'fore:'..colors.col_function
lexers.STYLE_ERROR = 'fore:'..colors.col_error..',italics'
lexers.STYLE_FUNCTION = 'fore:'..colors.col_function
lexers.STYLE_KEYWORD = 'fore:'..colors.col_keyword
lexers.STYLE_LABEL = 'fore:'..colors.col_keyword
lexers.STYLE_NUMBER = 'fore:'..colors.col_string
lexers.STYLE_OPERATOR = 'fore:'..colors.col_keyword
lexers.STYLE_REGEX = 'fore:'..colors.col_regex
lexers.STYLE_STRING = 'fore:'..colors.col_string
lexers.STYLE_PREPROCESSOR = 'fore:'..colors.col_preproc
lexers.STYLE_TAG = 'fore:'..colors.col_error
lexers.STYLE_TYPE = 'fore:'..colors.col_class
lexers.STYLE_VARIABLE = 'fore:'..colors.col_function
lexers.STYLE_WHITESPACE = 'fore:'..colors.fg_dark
lexers.STYLE_EMBEDDED = 'fore:'..colors.col_embedded
lexers.STYLE_IDENTIFIER = fg

lexers.STYLE_LINENUMBER = 'fore:'..colors.fg_dark..',back:'..colors.bg_light
lexers.STYLE_LINENUMBER_CURSOR = 'back:'..colors.fg_dark..',fore:'..colors.bg_light
lexers.STYLE_CURSOR = 'fore:'..colors.bg_dark..',back:'..colors.fg_normal
lexers.STYLE_CURSOR_PRIMARY = lexers.STYLE_CURSOR..',back:col_class'
lexers.STYLE_CURSOR_LINE = 'back:'..colors.bg_light
lexers.STYLE_COLOR_COLUMN = 'back:'..colors.bg_light
lexers.STYLE_SELECTION = 'back:'..colors.bg_light
--lexers.STYLE_SELECTION = 'back:white'
lexers.STYLE_STATUS = 'back:'..colors.bg_light..',fore:'..colors.fg_dark
lexers.STYLE_STATUS_FOCUSED = 'back:'..colors.bg_light..',fore:'..colors.fg_dark
lexers.STYLE_SEPARATOR = lexers.STYLE_DEFAULT
lexers.STYLE_INFO = 'fore:default,back:default,bold'
lexers.STYLE_EOF = 'fore:'..colors.fg_dark
