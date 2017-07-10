filetype indent plugin on                                   " determine the type of a file based on its name
syntax enable                                               " depends on filetype

set hidden                                                  " allow unsaved buffer to stay until vim closed
set showcmd                                                 " show currently typed commands on Vim's last line
set ignorecase smartcase                                    " use case insensitive search, except when using capital letters
set copyindent autoindent                                   " copy the previous indentation on autoindenting
set nostartofline                                           " stop certain movements from always going to the first character of a line
set title                                                   " change the terminal's title
set nobackup noswapfile                                     " don't use backup files with ~ and .swp
set ruler                                                   " display the cursor position on the buffer
set cursorline                                              " highlight line where the current cursor is in
set confirm                                                 " raise confirmation instead failing unsaved buffer
set cmdheight=2                                             " set the command window height to 2 lines
set relativenumber                                          " display line relative numbers on the left
set nowrap                                                  " don't wrap lines
set notimeout nottimeout                                    " no time out on keycodes and mappings
set list                                                    " show some special char to mark
set guicursor&                                              " reset to default neovim value (somehow it was set to nothing by default on st)

" map space to run command fast
noremap <Space> :
nnoremap : ,

let mapleader = ','
nnoremap <Leader>rf :nohl<CR><C-l>
nnoremap <Leader>tconf :tabe $MYVIMRC<CR>
nnoremap <Leader>vconf :vsplit $MYVIMRC<CR>
nnoremap <Leader>sconf :split $MYVIMRC<CR>
nnoremap <Leader>conf :e $MYVIMRC<CR>

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

inoremap <C-Space> <C-X><C-O>

tnoremap <Esc> <C-\><C-n>
tnoremap <A-h> <C-\><C-n><C-w>h
tnoremap <A-j> <C-\><C-n><C-w>j
tnoremap <A-k> <C-\><C-n><C-w>k
tnoremap <A-l> <C-\><C-n><C-w>l

noremap <F10> :call colorscheme#highlight_attribute()<CR>

cnoremap w!! w !sudo tee % > /dev/null

let g:netrw_banner = 0
let g:netrw_winsize = 25
