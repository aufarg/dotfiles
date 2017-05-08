"  __   __   ___   __  __
"  \ \ / /  |_ _| |  \/  |
"   \ V /    | |  | |\/| |
"   _\_/_   |___| |_|__|_|
" _| """"|_|"""""|_|"""""|
" `-0-0-'"`-0-0-'"`-0-0-'
"
"
" ######################### vimrc index  #########################
" 1. Default Configurations
" 2. Custom Functions
" 3. Plugins
" 4. Plugins Configurations
" 5. Autocommands
" ################################################################


" ######################### Default Configurations #########################
filetype indent plugin on " determine the type of a file based on its name
syntax enable " depends on filetype

set re=1 " use older version of regex engine since the new one sucks hard
set hidden " allow unsaved buffer to stay until vim closed
set showcmd " show currently typed commands on Vim's last line
set ignorecase smartcase " use case insensitive search, except when using capital letters
set copyindent " copy the previous indentation on autoindenting
set nostartofline " stop certain movements from always going to the first character of a line
set title " change the terminal's title
set nobackup noswapfile " don't use backup files with ~ and .swp
set ruler " display the cursor position on the buffer
set cursorline " highlight line where the current cursor is in
set confirm " raise confirmation instead failing unsaved buffer
set cmdheight=2 " set the command window height to 2 lines
set relativenumber " display line relative numbers on the left
set nowrap " don't wrap lines
set notimeout nottimeout " quickly time out on keycodes and never time out on mappings
set completeopt-=preview " remove scratch preview pane
set tabstop=8 shiftwidth=8 autoindent noexpandtab " default indentation settings for using 4-spaced tabs.
set list " show some special char to mark

" ######################### Custom Functions #########################
" Initialize HTML filetype options
function! HTMLInit()
	" Fix syntax coloring
	syn match htmlArg /\(\<\|-\)[a-zA-Z0-9-]\+\>/ contained
endfunction

" Latex functions
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

" Mutt Mail
function! MailInit()
	au FileType mail set textwidth=72
	au FileType mail setlocal fo+=aw
endfunction

" Python init
function! PythonInit()
	setlocal tabstop=4 softtabstop=4 shiftwidth=4 textwidth=80 smarttab expandtab
endfunction

" ######################### Key Mappings #########################
" Map space to run command fast
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

" ######################### Plugins #########################
" vim-plug configuration 
call plug#begin('~/.config/nvim/bundle')

" ##### Superb Plugins (god-like utilities) #####
Plug 'easymotion/vim-easymotion'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-repeat'
Plug 'SirVer/ultisnips'

" ##### Code #####
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'Raimondi/delimitMate' " autocomplete brackets, parentheses
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' } " autocomplete
Plug 'tpope/vim-commentary' " comments with gc<movement>
Plug 'tpope/vim-surround' " surround command
Plug 'matchit.zip' " % match tag in html
Plug 'sukima/xmledit' " edit xml
Plug 'zah/nim.vim' " nim language syntax highlighter
Plug 'lervag/vimtex' " latex syntax highlighter
Plug 'taglist.vim' " taglist browser for many different languages

" ##### Misc (add-ons) #####
Plug 'junegunn/vim-easy-align'
Plug 'kshenoy/vim-signature'
Plug 'mhinz/vim-signify'
Plug 'vimwiki/vimwiki'

" ##### Themes #####
Plug 'flazz/vim-colorschemes'
Plug 'itchyny/lightline.vim'

" Add plugins to &runtimepath
call plug#end()

" ######################### Builtin Tools Configurations #########################
" ##### cscope ####
if has('cscope')
	set cscopetag
	set nocscopeverbose
	if filereadable('cscope.out')
		silent! cscope add cscope.out
	endif
	set cscopeverbose
	nnoremap <C-_>s :cs find s <C-R>=expand("<cword>")<CR><CR>
	nnoremap <C-_>g :cs find g <C-R>=expand("<cword>")<CR><CR>
	nnoremap <C-_>c :cs find c <C-R>=expand("<cword>")<CR><CR>
	nnoremap <C-_>t :cs find t <C-R>=expand("<cword>")<CR><CR>
	nnoremap <C-_>e :cs find e <C-R>=expand("<cword>")<CR><CR>
	nnoremap <C-_>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
	nnoremap <C-_>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
	nnoremap <C-_>d :cs find d <C-R>=expand("<cword>")<CR><CR>
	nnoremap <C-_>a :cs find a <C-R>=expand("<cword>")<CR><CR>
endif

" ##### netrw ####
let g:netrw_banner = 0
let g:netrw_winsize = 25

" ######################### Plugins Configurations #########################
" ##### vim-lightline #####
let g:lightline = {
                  \ 'colorscheme': 'wombat',
                  \ 'active': {
                  \   'left': [ [ 'mode', 'paste' ],
                  \             [ 'fugitive', 'readonly', 'filename', 'modified' ] ]
                  \ },
                  \ 'component': {
                  \   'readonly': '%{&filetype=="help"?"":&readonly?"x":""}',
                  \   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}',
                  \   'fugitive': '%{exists("*fugitive#head")?fugitive#head():""}'
                  \ },
                  \ 'component_visible_condition': {
                  \   'readonly': '(&filetype!="help"&& &readonly)',
                  \   'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
                  \   'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())'
                  \ },
                  \ 'separator': { 'left': '⮀', 'right': '⮂' },
                  \ 'subseparator': { 'left': '|', 'right': '|' }
                  \ }

" ##### UltiSnip configuration #####
let g:UltiSnipsSnippetsDir='~/.vim/UltiSnips'
let g:UltiSnipsSnippetDirectories=[g:UltiSnipsSnippetsDir] + ["UltiSnips"]

" ##### filetype plugin #####
let g:tex_flavor = 'latex'

" ##### ctrlp configuration #####
let g:ctrlp_extensions = ['tag']

" #### Rainbow Parentheses configuration ####
let g:rainbow#max_level = 16
let g:rainbow#pairs = [['(', ')'], ['[', ']']]
let g:rainbow#blacklist = [233, 234]

" #### vim-easy-align configuration ####
vmap <Enter> <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" #### vim-easymotion configuration ####
let g:EasyMotion_smartcase = 1
let g:EasyMotion_use_upper = 1
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_keys = 'hjklyuiopnm,qweasdzxcrtfgvb;r'
map f <Plug>(easymotion-fl)
map F <Plug>(easymotion-Fl)
map t <Plug>(easymotion-tl)
map T <Plug>(easymotion-Tl)
map s <Plug>(easymotion-s2)
map ; <Plug>(easymotion-next)
map : <Plug>(easymotion-prev)

" #### vim-signify configuration ####
let g:signify_vcs_list = [ 'git' ]

" ##### deoplete.nvim configuration ####
let g:deoplete#enable_at_startup = 1
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function() abort
	return deoplete#close_popup() . "\<CR>"
endfunction


" ##### Theme configuration #####
set termguicolors
set background=dark

let g:gruvbox_contrast_dark = "hard"
colorscheme gruvbox
hi link EasyMotionTarget EasyMotionTarget2FirstDefault

" ##### Vimtex #####
let g:vimtex_latexmk_options = '-pdf -verbose -file-line-error -synctex=1 -interaction=nonstopmode -xelatex'
let g:vimtex_enabled = 1
let g:vimtex_view_method = 'zathura'
let g:vimtex_latexmk_build_dir = 'build'


" ##### Vimwiki #####
nmap <Leader>wls <Plug>VimwikiSplitLink
nmap <Leader>wlv <Plug>VimwikiVSplitLink
let g:vimwiki_list = [{
                      \ 'path': '~/vimwiki/',
                      \ 'template_path': '~/vimwiki/templates/',
                      \ 'template_default': 'vimwiki',
                      \ 'template_ext': '.html'
                      \ }]

" ######################### Autocommands #########################
if has("autocmd")
	" Auto-source files to current session after write
	aug auto_sources
		au!
		au BufWritePost ~/.vim/init.vim source $MYVIMRC
		au BufWritePost ~/.config/nvim/init.vim source $MYVIMRC
	aug END

	" Filetype set based on certain rules
	aug filetype_set
		au!
		au BufRead ~/.mutt/* setlocal filetype=muttrc
	aug END

	" Filetype initialization
	aug filetype_init
		au!
		au FileType tex call LatexInit()
		au FileType html call HTMLInit()
		au FileType mail call MailInit()
		au FileType python call PythonInit()
	aug END

	" Plugins autocommand
	aug plugins_autocommand
		au!
		au FileType c,c++ RainbowParentheses
	aug END
endif
