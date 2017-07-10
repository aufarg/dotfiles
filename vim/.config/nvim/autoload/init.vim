let s:cfgdir = fnamemodify($MYVIMRC, ':p:h')
let s:files = g:init#files
let s:aug = 'init'

func! init#all()
    call init#source_all()
    call init#register_hooks()
endfunc

func! init#register_hooks()
    let rcpaths = join([$MYVIMRC] + map(copy(s:files), 's:cfgdir . "/" . v:val'), ',')
    call init#auto('BufWritePost', rcpaths, 'call init#all()', v:true)
endfunc

func! init#source(fname)
    source `=s:cfgdir . '/' . a:fname`
endfunc

func! init#source_all()
    for fname in s:files
        call init#source(fname)
    endfor
endfunc

" autocmd wrapper to make sure it's in autocmd, and in the same autocmd group
if has('autocmd')
    func! init#auto(events, patterns, commands, ...)
        if !v:vim_did_enter
            let nested = ''
            if a:0 > 0
                if a:1 == v:true
                    let nested = 'nested'
                endif
            endif

            execute 'aug' s:aug
                execute 'au' a:events a:patterns nested a:commands
            aug END
        endif
    endfunc
else
    func! init#auto(events, patterns, commands, ...)
    endfunc
endif

func! init#prehook(patterns, commands)
    if type(a:patterns) == v:t_list
        let pat = join(a:patterns, ',')
    else
        let pat = a:patterns
    endif
    call init#auto('BufRead,BufNewFile,BufEnter',  pat, a:commands)
endfunc

func! init#fthook(patterns, commands)
    if type(a:patterns) == v:t_list
        let pat = join(a:patterns, ',')
    else
        let pat = a:patterns
    endif
    call init#auto('FileType',  pat, a:commands)
endfunc
