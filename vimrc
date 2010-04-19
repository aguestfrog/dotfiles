set nocompatible " use VIM defaults
set background=dark 
set ruler        " show cursor position all the time
set showcmd      " show (partial) command in status line
set number       " show line numbers
set showmatch    " show matching brackets
set hlsearch     " highlight search matches
set incsearch    " incremental search while typing
set ignorecase   " ignore case in search patterns
set smartcase    " .. except search pattern contains upper case char.
set backspace=indent,eol,start " proper backspace
set autoindent   " copy indent from current line to new line
set smartindent  " smart autoindenting when starting a new line
" tabs
set shiftwidth=4
set tabstop=4
set expandtab
set nocp

" uniform colors between different terminals
set t_Co=8

" haskell
let hs_highlight_boolean=1
let hs_highlight_types=1
let hs_highlight_debug=1

syntax on
filetype plugin on
filetype indent on


