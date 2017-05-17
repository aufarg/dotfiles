function! s:CSFilepath(patterns, commands)
    execute 'au BufRead,BufNewFile,BufEnter' join(a:patterns, ',') a:commands
endfunction

function! s:CSFiletype(types, commands)
    execute 'au Filetype' join(a:types, ',') a:commands
endfunction

aug codestyle
    au!
    call s:CSFilepath([
                     \ fnamemodify($MYVIMRC, ":p:h") . '/*',
                     \ $HOME.'*/xen/*.{c,h}',
                     \ ], 'setlocal sw=4 et')
    call s:CSFiletype([
                     \ 'zsh',
                     \ ], 'setlocal sw=4 et')
aug END
