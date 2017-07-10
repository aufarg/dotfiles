if has('cscope')
	set cscopetag
	set nocscopeverbose
	if filereadable('cscope.out')
		silent! cscope add cscope.out
	endif
	set cscopeverbose

	if has('quickfix')
            set cscopequickfix=s-,c-,d-,i-,t-,e-,a-
        endif

	nnoremap <C-_>s :cs find s <C-R><C-W><CR>
	nnoremap <C-_>g :cs find g <C-R><C-W><CR>
	nnoremap <C-_>c :cs find c <C-R><C-W><CR>
	nnoremap <C-_>t :cs find t <C-R><C-W><CR>
	nnoremap <C-_>e :cs find e <C-R><C-W><CR>
	nnoremap <C-_>f :cs find f <C-R><C-F><CR>
	nnoremap <C-_>i :cs find i ^<C-R><C-F>$<CR>
	nnoremap <C-_>d :cs find d <C-R><C-W><CR>
	nnoremap <C-_>a :cs find a <C-R><C-W><CR>
endif
