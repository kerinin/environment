set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'

" My Bundles here:
"
" original repos on github
Bundle 'tpope/vim-fugitive'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
Bundle 'tpope/vim-rails.git'
Bundle 'Color-Sampler-Pack'
Bundle 'matchit.zip'
Bundle 'textobj-user'
Bundle 'textobj-rubyblock'
Bundle 'The-NERD-tree'
Bundle 'multvals.vim'
" Bundle 'genutils.vim'
Bundle 'dbext.vim'
Bundle 'surround.vim'
Bundle 'taglist.vim'
Bundle 'ZoomWin'
Bundle 'vim-coffee-script'
Bundle 'vim-stylus'
Bundle 'Indent-Guides'
" vim-scripts repos
" Bundle 'L9'
" Bundle 'FuzzyFinder'
" non github repos
" Bundle 'git://git.wincent.com/command-t.git'
" ...

filetype plugin indent on     " required! 
"
" Brief help
" :BundleList          - list configured bundles
" :BundleInstall(!)    - install(update) bundles
" :BundleSearch(!) foo - search(or refresh cache first) for foo
" :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Bundle command are not allowed..

set nu " show line numbers

if has("gui_running")
	set guioptions=egmrt " remove chrome cruft from window
endif

set shiftwidth=2 " pretty tabs
set tabstop=2

" set nowrap " let text extend off screen if too long
