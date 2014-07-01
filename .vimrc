call pathogen#infect()
runtime macros/matchit.vim

set nocompatible
set backspace=indent,eol,start

filetype off
syntax enable
filetype plugin indent on

" Folding settings
" nmap z1 :set foldenable<cr> :set foldlevel=1<cr>
" nmap z2 :set foldenable<cr> :set foldlevel=2<cr>
" nmap z3 :set foldenable<cr> :set foldlevel=3<cr>
" nmap z4 :set foldenable<cr> :set foldlevel=4<cr>
" set foldmethod=syntax
" set foldlevel=2
" set nofoldenable

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
let g:NERDTreeWinSize = 40

set background=dark
silent! colorscheme solarized
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

set mouse=a
augroup filetypedetect 
  au BufNewFile,BufRead *.pig set filetype=pig syntax=pig 
augroup END

au WinLeave * set nocursorline nocursorcolumn
au WinEnter * set cursorline cursorcolumn
set cursorline cursorcolumn

au BufRead,BufNewFile *.pde set filetype=arduino
au BufRead,BufNewFile *.ino set filetype=arduino

" Always display the path
set laststatus=2

" Turn on paren coloring
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces
let g:rbpt_max = 8

highlight Comment cterm=italic

let g:Powerline_symbols = 'fancy'

" Set cursor based on insert/select mode
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

let g:markdown_fenced_languages = ['ruby', 'sh', 'javascript']
