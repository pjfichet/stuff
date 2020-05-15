" Vim syntax file
" Filename: list.vim
" Language: marked text for bnk files
" Maintainer: Pierre-Jean Fichet
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" INSTALL: (as user)
"
" - Copy this file to the ~/.vim/syntax/ dir (create it if necessary)
"
" - Put in your .vimrc the following line:
"   au BufNewFile,BufRead *.bnk set ft=bnk
"
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" INSTALL: (as superuser)
"
" If you have access to the system configuration, edit the
" /usr/share/vim/vim*/filetype.vim file, adding the following
" lines after the 'Z-Shell script' entry (near the end):
"
"   " bnk file
"   au BufNewFile,BufRead *.bnk set ft=bnk
"
" And copy this file (bnk.vim) to the Vim syntax dir:
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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"FONT BEAUTIFIERS:
syn match   ListOld        '^O....'
syn match   ListNew          '^N....'
syn match   ListImportant       '^I....'
syn match   ListCommand '^:.*'
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" color definitions (using Vim defaults)
"Delimiter Error Special Identifier Statement Comment Conditional
"Funtion Number Operator Repeat PreProc String TODO  SpecialChar
"Folded Type Normal WarningMsg
hi link ListOld   Special
hi link ListNew  Type
hi link ListImportant     Statement
hi link ListCommand   PreProc
hi link PacmanTag4 Normal

let b:current_syntax = 'list'
" vim:tw=0:et
