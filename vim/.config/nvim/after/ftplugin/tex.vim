call deoplete#custom#var('omni', 'input_patterns', {
            \ 'tex': '\\(?:'
                \ .  '\w*cite\w*(?:\s*\[[^]]*\]){0,2}\s*{[^}]*'
                \ . '|\w*ref(?:\s*\{[^}]*|range\s*\{[^,}]*(?:}{)?)'
                \ . '|hyperref\s*\[[^]]*'
                \ . '|includegraphics\*?(?:\s*\[[^]]*\]){0,2}\s*\{[^}]*'
                \ . '|(?:include(?:only)?|input)\s*\{[^}]*'
                \ . '|\w*(gls|Gls|GLS)(pl)?\w*(\s*\[[^]]*\]){0,2}\s*\{[^}]*'
                \ . '|includepdf(\s*\[[^]]*\])?\s*\{[^}]*'
                \ . '|includestandalone(\s*\[[^]]*\])?\s*\{[^}]*'
                \ . '|usepackage(\s*\[[^]]*\])?\s*\{[^}]*'
                \ . '|documentclass(\s*\[[^]]*\])?\s*\{[^}]*'
                \ . '|\w*'
                \ .')',
            \ })

func! s:latex_wrap_command(command, type)
    let reg = '"'
    let sel_save = &selection
    let &selection = 'inclusive'
    let reg_save = getreg(reg)
    let reg_type = getregtype(reg)
    let ok = 1
    if a:type == 'char'
        silent exe 'norm! `[v`]y'
    elseif a:type ==# 'v' || a:type ==# 'V' || a:type ==# '\<C-v>'
        silent exe 'norm! gvy'
    else
        ok = 0
        echomsg a:type.' is not supported'
    endif
    if ok
        let content = getreg(reg)
        let content_reg_type = getregtype(reg)
        let content = substitute(content, '\(.*\)', a:command.'{\1}', '')
        call setreg(reg, content, content_reg_type)
        exe 'norm! gv"'.reg.'p`['
        call setreg(reg, reg_save, reg_type)
    endif
    let &selection = sel_save
endfunc

func! s:latex_italic(type, ...)
    call s:latex_wrap_command('\\textit', a:type)
endfunc

func! s:latex_bold(type, ...)
    call s:latex_wrap_command('\\textbf', a:type)
endfunc

nnoremap <silent><buffer> <plug>(tex-iwrap-n) :<C-U>set opfunc=<sid>latex_italic<cr>g@
vnoremap <silent><buffer> <plug>(tex-iwrap-v) :<C-U>call <sid>latex_italic(visualmode())<cr>
nnoremap <silent><buffer> <plug>(tex-bwrap-n) :<C-U>set opfunc=<sid>latex_bold<cr>g@
vnoremap <silent><buffer> <plug>(tex-bwrap-v) :<C-U>call <sid>latex_bold(visualmode())<cr>
