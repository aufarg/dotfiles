if exists("b:did_custom_after_ftplugin")
    finish
endif

let b:did_custom_after_ftplugin = 1

setlocal et
setlocal foldlevel=0
setlocal commentstring=#%s
