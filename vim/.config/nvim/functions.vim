" initialize html filetype options
function! HTMLInit()
	" fix syntax coloring
	syn match htmlArg /\(\<\|-\)[a-zA-Z0-9-]\+\>/ contained
endfunction

" latex functions
function! LatexWrapCommand(command, type)
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
endfunction

function! LatexItalicize(type, ...)
	call LatexWrapCommand('\\textit', a:type)
endfunction

function! LatexBold(type, ...)
	call LatexWrapCommand('\\textbf', a:type)
endfunction

function! LatexInit()
	nnoremap <silent> <LocalLeader>i :<C-U>set operatorfunc=LatexItalicize<CR>g@
	vnoremap <silent> <LocalLeader>i :<C-U>call LatexItalicize(visualmode())<CR>
	nnoremap <silent> <LocalLeader>b :<C-U>set operatorfunc=LatexBold<CR>g@
	vnoremap <silent> <LocalLeader>b :<C-U>call LatexBold(visualmode())<CR>
endfunction

" mutt mail
function! MailInit()
	au FileType mail set textwidth=72
	au FileType mail setlocal fo+=aw
endfunction

" python init
function! PythonInit()
	setlocal tabstop=4 softtabstop=4 shiftwidth=4 textwidth=80 smarttab expandtab
endfunction

