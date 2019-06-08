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
Plugin 'google/vim-maktaba'
Plugin 'bazelbuild/vim-bazel'
Plugin 'google/vim-codefmt'
Plugin 'google/vim-glaive'
Plugin 'rhysd/vim-clang-format'
Plugin 'jparise/vim-graphql'
Plugin 'reasonml-editor/vim-reason-plus'
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'
" Plugin 'prettier/vim-prettier', {
"   \ 'do': 'yarn install',
"   \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html'] }
Plugin 'w0rp/ale'


" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

call glaive#Install()
Glaive codefmt plugin[mappings]
Glaive codefmt google_java_executable="java -jar /path/to/google-java-format-VERSION-all-deps.jar"
Glaive codefmt clang_format_executable='clang-format'

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
" Note - using codefmt now
" let g:go_fmt_autosave = 1
" let g:go_fmt_fail_silently = 1
" let g:go_fmt_command = "goimports"
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

colorscheme base16-default-dark

autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

augroup autoformat_settings
  autocmd FileType bzl AutoFormatBuffer buildifier
  " autocmd FileType c,cpp,proto,javascript AutoFormatBuffer clang-format
  autocmd FileType dart AutoFormatBuffer dartfmt
  autocmd FileType go AutoFormatBuffer gofmt
  autocmd FileType gn AutoFormatBuffer gn
  autocmd FileType html,css,json AutoFormatBuffer js-beautify
  autocmd FileType java AutoFormatBuffer google-java-format
  autocmd FileType python AutoFormatBuffer yapf
  autocmd FileType re AutoFormatBuffer refmt
  " Alternative: autocmd FileType python AutoFormatBuffer autopep8
augroup END

let g:terraform_fmt_on_save = 1

" speed up godef https://github.com/fatih/vim-go/issues/1877
let g:go_def_mode = 'godef'

let g:ale_reasonml_refmt_executable = '/usr/local/bin/refmt'
let g:ale_fixers = {'reason': ['refmt'], 'javascript': ['prettier', 'eslint']}
let g:ale_fix_on_save = 1

set nobackup
set nowritebackup
set wildignore+=*.bs.js,*.pyc,*.o,*.obj,*.svn,*.swp,*.class,*.hg,*.DS_Store,*.min.*
let NERDTreeRespectWildIgnore=1
