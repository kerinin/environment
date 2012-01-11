set foldcolumn=4
set foldlevel=1
set foldmethod=syntax

" set folding to indent for coffescript
au BufNewFile,BufReadPost *.coffee setl foldmethod=indent 
au BufNewFile,BufReadPost *.haml setl foldmethod=indent 

colorscheme darkspectrum

set nofoldenable
" it would be nice if turning foldenable on also turned on the foldcolumn
