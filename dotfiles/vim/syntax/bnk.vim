" Vim syntax file
" Filename: bnk.vim
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
syn match   bnkComment        '^#.*'
syn match   bnkCheck          '^>'
syn match   bnkIndex        '{.*}'
syn match   bnkMinux        '-'
syn match   bnkPlus         '+'
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" color definitions (using Vim defaults)
"Delimiter Error Special Identifier Statement Comment Conditional
"Funtion Number Operator Repeat PreProc String TODO  SpecialChar
"Folded Type Normal WarningMsg
hi link bnkComment        Comment
hi link bnkCheck         Statement 
hi link bnkIndex         Number 
hi link bnkMinux        Special
hi link bnkPlus         Type

let b:current_syntax = 'bnk'
" vim:tw=0:et
