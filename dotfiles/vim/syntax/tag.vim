" Vim syntax file
" Filename: tag.vim
" Language: marked text for conversion by txt2tags
" Maintainer: Aurelio Jargas
" Last change: 20060801 - v2.3.2 t2tCommentArea, %!include & macro start body
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" INFO:
"
" - This is the txt2tags VIM syntax file.
" - It's a syntax file just like those for programming languages as C
"   or Python, so you know it's handy.
" - Here are registered all the structures for txt2tags marks.
" - When composing your text file, the marks will be highlighted,
"   helping you to quickly make error-free txt2tags files.
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" FOLD:
"
" - There are some folding rules on the syntax also
" - To use fold just uncomment the line of foldmethod below
" - Or set the fold use directly on the t2t file, adding this last line:
"
"     % vim: foldmethod=syntax
"
" - There are two kinds of fold:
"
"   Automatic fold:
"     - The fold starts at any top level title
"     - The fold ends with 3 consecutive blank lines
"
"   User defined fold:
"     - The fold starts by the "% label {{{" comment
"     - The fold ends with the "% }}}" comment
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" INSTALL: (as user)
"
" - Copy this file to the ~/.vim/syntax/ dir (create it if necessary)
"
" - Put in your .vimrc the following line:
"   au BufNewFile,BufRead *.t2t set ft=txt2tags
"
" If you use other extension for txt2tags files, change the '*.t2t'
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" INSTALL: (as superuser)
"
" If you have access to the system configuration, edit the
" /usr/share/vim/vim*/filetype.vim file, adding the following
" lines after the 'Z-Shell script' entry (near the end):
"
"   " txt2tags file
"   au BufNewFile,BufRead *.t2t                 setf txt2tags
"
" And copy this file (txt2tags.vim) to the Vim syntax dir:
"
"   /usr/share/vim/vim*/syntax/
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"FOLD: just uncomment the following line if you like to use Vim fold
"set foldmethod=syntax


" init
syn clear
syn sync minlines=500
syn case ignore

"TODO see if user already has foldmethod defined, if so, set foldmethod=syntax
"TODO2 learn vim language :/

syn cluster t2tComponents  contains=t2tNumber,t2tPercent,t2tMacro,t2tImg,t2tEmail,t2tUrl,t2tUrlMark,t2tUrlMarkImg,t2tUrlLocal
syn cluster t2tBeautifiers contains=t2tStrike,t2tUnderline,t2tItalic,t2tBold,t2tMonospace,t2tRaw

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"LIST:
syn match t2tList    '^ *[-+:]\s*$'
syn match t2tList    '^ *: '
syn match t2tList    '^ *[+-] [^ ]'me=e-1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"FONT BEAUTIFIERS:
syn match   t2tNote         '{{\S\(\|.\{-}\S\)}}\+'hs=s+2,he=e-2
syn match   t2tTitle        '=\+ \S\(\|.\{-}\S\) =\+'
syn match   t2tCaps        '::\S\(\|.\{-}\S\)::\+'hs=s+2,he=e-2
syn match   t2tQuote        '\[\[\S\(\|.\{-}\S\)\]\]\+'hs=s+2,he=e-2
syn match   t2tBold       '\*\*\S\(\|.\{-}\S\)\*\*\+'hs=s+2,he=e-2
syn match   t2tItalic       '//\S\(\|.\{-}\S\)//\+'hs=s+2,he=e-2
syn match   t2tUnderline    '__\S\(\|.\{-}\S\)__\+'hs=s+2,he=e-2
syn match   t2tStrike       '--\S\(\|.\{-}\W\)--\+'hs=s+2,he=e-2
syn match   t2tRaw          '""\S\(\|.\{-}\S\)""\+'hs=s+2,he=e-2
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" color definitions (using Vim defaults)
hi link t2tTitle        Todo
hi link t2tNote         Special
hi link t2tList         Special 
hi link t2tQuote        Number
" color definitions (specific)
hi t2tBar         term=bold        cterm=bold        gui=bold
hi t2tBold        term=bold        cterm=bold        gui=bold
hi t2tItalic      term=italic      cterm=italic      gui=italic
hi t2tStrike      term=italic      cterm=italic      gui=italic
hi t2tUnderline   term=underline   cterm=underline   gui=underline
hi t2tCaps        term=bold     cterm=bold     gui=bold
"
let b:current_syntax = 'txt2tags'
" vim:tw=0:et
