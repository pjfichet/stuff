-- Solarized color codes Copyright (c) 2011 Ethan Schoonover
local lexers = vis.lexers

local colors = {
	bg_dark  = '#102948', -- background
	bg_light  = '#183456', -- line cursor bg
	fg_dark  = '#72898f', -- comment whitespace eof fg
	fg_normal   = '#adbcbc', -- foreground
	fg_light   = '#cad8d9', -- status focused bg
	col_class  = '#ff84cd', -- class, type
	col_preproc  = '#dbb32d', -- preprocessor
	col_error     = '#fa5750', -- error, tag
	col_embedded = '#75b938', -- embedded
	col_regex  = '#58a3ff', -- regex
	col_function    = '#f275be', -- function, variable, embedded
	col_string    = '#41c7b9', -- constant, number, string
	col_keyword   = '#4695f7', -- keyword, label, operator
	light_blue = '#58a3ff',
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
