set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Access colors present in 256 colorspace
let base16colorspace=256

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" " The following are examples of different formats supported.
" " Keep Plugin commands between vundle#begin/end.
" " plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-liquid'
Plugin 'tpope/vim-markdown'
" " plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" " Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'
" " git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" " The sparkup vim script is in a subdirectory of this repo called vim.
" " Pass the path to set the runtimepath properly.
" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" " Avoid a name conflict with L9
" Plugin 'user/L9', {'name': 'newL9'}
Plugin 'chriskempson/base16-vim'
Plugin 'ekalinin/Dockerfile.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'motus/pig.vim'
"? Bundle 'motus/pig.vim'
Plugin 'wting/rust.vim'
Plugin 'cakebaker/scss-syntax.vim'
Plugin 'slim-template/vim-slim.git'
Plugin 'majutsushi/tagbar'
Plugin 'tomtom/tcomment_vim'
Plugin 'kana/vim-textobj-user'
Plugin 'fatih/vim-go'
Plugin 'ingydotnet/yaml-vim'
Plugin 'uarun/vim-protobuf'
Plugin 'markcornick/vim-terraform'
Plugin 'elubow/cql-vim'
Plugin 'Chiel92/vim-autoformat'
Plugin 'dcharbon/vim-flatbuffers'
Plugin 'cstrahan/vim-capnp'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'vim-scripts/groovyindent-unix'
Plugin 'djoshea/vim-autoread'


" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line


" call pathogen#infect()
" runtime macros/matchit.vim

" set nocompatible
set backspace=indent,eol,start

" filetype off
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
" set background=light
" silent! colorscheme solarized
if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif
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
au Filetype markdown setlocal spell tw=80

au WinLeave * set nocursorline nocursorcolumn
au WinEnter * set cursorline cursorcolumn
set cursorline cursorcolumn

au BufRead,BufNewFile *.pde set filetype=arduino
au BufRead,BufNewFile *.ino set filetype=arduino

" Always display the path
set laststatus=2

" Turn on paren coloring
" au VimEnter * RainbowParenthesesToggle
" au Syntax * RainbowParenthesesLoadRound
" au Syntax * RainbowParenthesesLoadSquare
" au Syntax * RainbowParenthesesLoadBraces
" let g:rbpt_max = 8

" highlight Comment cterm=italic

" let g:Powerline_symbols = 'fancy'

" Set cursor based on insert/select mode
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

let g:markdown_fenced_languages = ['ruby', 'sh', 'javascript', 'lisp']

" Show the 80-character margin
:set colorcolumn=80

" Go
let g:go_fmt_autosave = 1
let g:go_fmt_fail_silently = 1
let g:go_fmt_command = "goimports"
au BufNewFile,BufRead *.go setlocal noet ts=4 sw=4 sts=4
au FileType php setl sw=4 sts=4 et

" add jbuilder syntax highlighting
au BufNewFile,BufRead *.jbuilder set ft=ruby

" tagbar
" nmap <F8> :TagbarToggle<CR>

" Don't do horizontal splits
set diffopt+=vertical

" go stuff
set rtp+=$GOPATH/src/github.com/golang/lint/misc/vim
autocmd BufWritePost,FileWritePost *.go execute 'Lint' | cwindow
au Filetype go nnoremap <leader>g :vsplit <CR>:exe "GoDef"<CR>
au Filetype go nnoremap <leader>f :exe "GoDef"<CR>

" rust stuff
" let g:formatdef_rustfmt = '"rustfmt"'
" let g:formatters_rust = ['rustfmt']
" au BufWrite *.rs :Autoformat

" python stuff
au BufNewFile,BufRead *.py set expandtab autoindent tabstop=4 softtabstop=4 shiftwidth=4 textwidth=79 fileformat=unix

" Jenkinsfiles
au BufNewFile,BufRead Jenkinsfile setf groovy

au BufNewFile,BufRead BUILD      setf bzl
au BufNewFile,BufRead BUILD.bazel   setf bzl
