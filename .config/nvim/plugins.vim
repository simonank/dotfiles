call plug#begin('~/.local/share/nvim/bundle')
	" LANGUAGE
	Plug 'idris-hackers/idris-vim'       , { 'for': 'idris' }
	Plug 'ngn/vim-apl'                   , { 'for': 'apl' }
	Plug 'adimit/prolog.vim'             , { 'for': 'prolog' }
	Plug 'Twinside/vim-hoogle'           , { 'for': 'haskell' }
	Plug 'neovimhaskell/haskell-vim'     , { 'for': 'haskell' }
	Plug 'mpickering/hlint-refactor-vim' , { 'for': 'haskell' }
"	Plug 'eagletmt/ghcmod-vim'           , { 'for': 'haskell' }
"	Plug 'vim-scripts/hlint'             , { 'for': 'haskell' }
"	Plug 'bitc/vim-hdevtools'            , { 'for': 'haskell' }
"	Plug 'eagletmt/neco-ghc'             , { 'for': 'haskell' }
	Plug 'Quramy/tsuquyomi'              , { 'for': 'typescript' }
	Plug 'leafgarland/typescript-vim'    , { 'for': 'typescript' }
	Plug 'jason0x43/vim-js-indent'       , { 'for': 'typescript' }
	Plug 'elixir-lang/vim-elixir'        , { 'for': 'elixir' }
"	Plug 'slashili/alchemist'            , { 'for': 'elixir' }
	Plug 'rust-lang/rust.vim'            , { 'for': 'rust' }
"	Plug 'vim-scripts/paredit.vim'       , { 'for': ['lisp' , 'clojure' , 'scheme'] }
	Plug 'udalov/kotlin-vim'             , { 'for': 'kotlin' }
"	Plug 'valloric/youcompleteme'        , { 'do': 'python install.py --omnisharp-completer' }
	Plug 'fatih/vim-go'                  , { 'for': 'go' }
	Plug 'KeitaNakamura/tex-conceal.vim' , { 'for': 'tex' }
"	Plug 'the-lambda-church/coquille'    , { 'for': 'coq' }
"	Plug 'vim-scripts/CoqIDE'            , { 'for': 'coq' }
"	Plug 'autozimu/LanguageClient'       , { 'branch': 'next', 'do': './install.sh'}
	Plug 'elmcast/elm-vim'               , { 'for': 'elm' }
	Plug 'raichoo/purescript-vim'
	Plug 'vim-scripts/coq-syntax'        , { 'for': 'coq' }
"	Plug 'OmniSharp/omnisharp-vim'       , { 'for': 'csharp' }
	Plug 'derekelkins/agda-vim'          , { 'for': 'agda' }

	" SYNTAX
	Plug 'luochen1990/rainbow'
	Plug 'junegunn/limelight.vim'
"	Plug 'calebsmith/vim-lambdify'
	Plug 'scrooloose/syntastic'
	Plug 'jceb/vim-orgmode'
	Plug 'panagosg7/vim-annotations'
	Plug 'justinmk/vim-syntax-extra'
	Plug 'godlygeek/tabular'
	Plug 'bronson/vim-trailing-whitespace'
	Plug 'LnL7/vim-nix'
	Plug 'mpickering/hlint-refactor-vim'
" THEME
	Plug 'lifepillar/vim-wwdc17-theme'
	Plug 'whatyouhide/vim-gotham'
	"Plug 'itchyny/lightline.vim'
	Plug 'elmindreda/vimcolors'

	" PROC
"	Plug 'Shougo/vimproc'                , { 'do': 'make' }
"	Plug 'shougo/vimshell.vim'
"	Plug 'jpalardy/vim-slime'
"	Plug 'ujihisa/repl.vim'
	Plug 'ervandew/supertab'
	Plug 'skywind3000/asyncrun.vim'

	" PROJECT
	Plug 'dietsche/vim-lastplace'
	Plug 'airblade/vim-gitgutter'
	Plug 'Xuyuanp/nerdtree-git-plugin'
	Plug 'scrooloose/nerdtree'
	Plug 'hsanson/vim-android'
	Plug 'tpope/vim-fugitive'
	Plug 'tpope/vim-unimpaired'
	Plug 'majutsushi/tagbar'

	" MISC
	Plug 'MarcWeber/vim-addon-mw-utils'
	Plug 'garbas/vim-snipmate'
	Plug 'tomtom/tlib_vim'
call plug#end()
