" Vim syntax file
" Filename: pacman.vim
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
syn match   PacmanWarning        'warning.*'
syn match   PacmanUpgraded        'upgraded'
syn match   PacmanInstalled          'installed'
syn match   PacmanRemoved       'removed'
syn match   PacmanSynchro 'synchronizing package lists'
syn match   PacmanSystemup 'starting full system upgrade'
syn match   PacmanRunning 'Running.*'
syn match   PacmanTag1   '>>>'
syn match   PacmanTag2   '==>'
syn match   PacmanTag4   '::'
syn match   PacmanALPM  'ALPM-SCRIPTLET'
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" color definitions (using Vim defaults)
"Delimiter Error Special Identifier Statement Comment Conditional
"Funtion Number Operator Repeat PreProc String TODO  SpecialChar
"Folded Type Normal WarningMsg
hi link PacmanWarning   Special
hi link PacmanUpgraded  Normal
hi link PacmanInstalled  Type
hi link PacmanRemoved     Statement
hi link PacmanSynchro   PreProc
hi link PacmanSystemup PreProc
hi link PacmanRunning PreProc
hi link PacmanTag1 Normal
hi link PacmanTag2 Normal
hi link PacmanTag3 Normal
hi link PacmanTag4 Normal
hi link PacmanALPM Statement

let b:current_syntax = 'bnk'
" vim:tw=0:et
