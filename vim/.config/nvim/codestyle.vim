function! s:CodeStyle(patterns, commands)
    execute 'au BufRead,BufNewFile,BufEnter' join(a:patterns, ',') a:commands
endfunction

aug codestyle
    au!
    call s:CodeStyle([
                     \ fnamemodify($MYVIMRC, ":p:h") . '/*',
                     \ $HOME.'*/xen/*.{c,h}',
                     \ ], 'setlocal sw=4 et')
aug END
