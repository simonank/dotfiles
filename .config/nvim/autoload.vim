au BufNewFile,BufRead *.idr,*.hs,*.scm,*.lhs,*.lidr,*.sats set expandtab
au BufNewFile,BufRead *.lisp,*.clj,*.cabal,*.lua,*dats set expandtab
au BufNewFile,BufRead *.lidr set filetype=idris | set filetype=lidris
au BufNewFile,BufRead *.pl set filetype=prolog
au BufNewFile,BufRead *.apl set kmp=dyalog
au BufNewFile,BufRead *.dats,*.sats set filetype=dats
au BufNewFile,BufRead *.scm,*.clj,*.lisp RainbowToggleOn
au BufNewFile,BufRead *.s set filetype=nasm
au BufNewFile,BufRead *.v set filetype=coq
au BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif | call TabularMap()
au VimEnter * if (isdirectory($PWD . "/.git")) | NERDTree | GitGutterEnable | endif
au VimEnter * if (!isdirectory($HOME . "/.vim_backup")) | call mkdir($HOME . "/.vim_backup") | endif
"au BufWritePost *.hs GhcModLintAsync " ghcid > ghc-mod

au BufNewFile,BufRead *.c,*.sats,*.dats :copen
" STATIC CHECKERS
au BufWritePost *.sats AsyncRun patsopt -tc --debug2 -s '%'
au BufWritePost *.dats AsyncRun patsopt -tc --debug2 -d '%'
"au BufWritePost *.c    AsyncRun splint '%'
"au BufWritePost *.hs,*.lhs AsyncRun ghc -e 'pure ()' '%'
"hlint -h$HOME/.hlint.yaml '%'

"au FileType haskell setlocal omnifunc=necoghc#omnifunc
"au BufWritePost .vimrc source ~/.vimrc

