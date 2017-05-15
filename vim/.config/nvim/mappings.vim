" ########## general ##########
" map space to run command fast
noremap <Space> :
noremap q<Space> q:
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
noremap <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
                    \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
                    \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

cnoremap w!! w !sudo tee % > /dev/null

