call pathogen#infect()
runtime macros/matchit.vim

set nocompatible
set backspace=indent,eol,start

filetype off
syntax enable
filetype plugin indent on

if has("autocmd")
  filetype indent plugin on
endif

let mapleader=","

set ts=4 sts=2 sw=2 expandtab

" Easier window nav
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l

nmap <silent> <leader>n :NERDTreeToggle<cr>

set background=dark
colorscheme solarized
set number
set nowrap
set linebreak
set winwidth=85
set encoding=utf-8

" Search highlighting.  
" highlights the next match as you type, then all the
" matches after enter.  Defaults to case-insensitive,
" but does sensitive if you type a capital letter
" Spacebar clears search results
set hlsearch
set ignorecase
set smartcase
set incsearch
:nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

" Don't leave .swp all over the place
set noswapfile
