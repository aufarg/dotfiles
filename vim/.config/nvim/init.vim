" list of rc files located in the same folder as this file ($MYVIMRC)
" note: orders matters
let init#files = [
      \ 'plugins.vim',
      \ 'default.vim',
      \ 'cscope.vim',
      \ ]

" ---------- don't peek ----------

call init#all()

call init#prehook('*/xen/*.{c,h}', 'setlocal sw=4 et')

nmap <localleader>i <plug>(tex-iwrap-n)
nmap <localleader>b <plug>(tex-bwrap-n)
vmap <localleader>i <plug>(tex-iwrap-v)
vmap <localleader>b <plug>(tex-bwrap-v)

