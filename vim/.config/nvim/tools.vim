" ##### cscope ####
if has('cscope')
	set cscopetag
	set nocscopeverbose
	if filereadable('cscope.out')
		silent! cscope add cscope.out
	endif
	set cscopeverbose

	nnoremap <C-_>s :cs find s <C-R><C-W><CR><CR>
	nnoremap <C-_>g :cs find g <C-R><C-W><CR><CR>
	nnoremap <C-_>c :cs find c <C-R><C-W><CR><CR>
	nnoremap <C-_>t :cs find t <C-R><C-W><CR><CR>
	nnoremap <C-_>e :cs find e <C-R><C-W><CR><CR>
	nnoremap <C-_>f :cs find f <C-R><C-F><CR><CR>
	nnoremap <C-_>i :cs find i ^<C-R><C-F><CR>$<CR>
	nnoremap <C-_>d :cs find d <C-R><C-W><CR><CR>
	nnoremap <C-_>a :cs find a <C-R><C-W><CR><CR>
endif

" ##### netrw ####
let g:netrw_banner = 0
let g:netrw_winsize = 25

" ##### grep ####
if executable('ag')
	let g:ag_max_match_per_file = 20
	let &grepprg='ag --nogroup --nocolor --max-count ' . g:ag_max_match_per_file
	nnoremap <leader>/ :Find<space>
	nnoremap <leader>* :Find <C-R><C-W><CR>
endif

if executable('ag')
	function! QFGrep(query)
		let matches = matchlist(a:query, "\\v('.{-1,}'|[^' ][^ ]*)( ('.{-1,}' ?|[^' ].* ?))?")
		let search_query  = matches[1]
		let search_root   = matches[2]

		if match(search_query, "\\v'.{-1,}'") != -1
			let search_query = substitute(search_query, "\\v^'|'$", "", "g")
		endif

		let escaped_search_query = shellescape(search_query, 1)
		execute 'grep' escaped_search_query search_root
		redraw!
		copen
	endfunction
	command! -complete=file -nargs=* Find call QFGrep(<q-args>)
endif
