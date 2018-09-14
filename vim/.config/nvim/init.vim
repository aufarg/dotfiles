let mapleader = ','

" vim-plug
call plug#begin('~/.cache/nvim-plugins')
Plug 'junegunn/vim-plug'

" c/c++/objc completion
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' } " autocomplete
Plug 'zchee/deoplete-clang' " deoplete source for C/C++
Plug 'Shougo/neoinclude.vim' " source from included file (C/C++)

" haskell completion
Plug 'eagletmt/neco-ghc'

" python completion
Plug 'zchee/deoplete-jedi' " deoplete source for Python

" ftplugins
Plug 'sheerun/vim-polyglot'

" code
Plug 'neomake/neomake'
Plug 'ludovicchabant/vim-gutentags' " auto (re)generate ctag file
Plug 'junegunn/rainbow_parentheses.vim' " colorize parentheses
Plug 'Raimondi/delimitMate' " autocomplete brackets, parentheses
Plug 'majutsushi/tagbar' " taglist browser for many different languages
Plug 'sukima/xmledit' " edit xml
Plug 'tpope/vim-commentary' " comments with gc<movement>
Plug 'tpope/vim-surround' " surround command

" utility
Plug 'easymotion/vim-easymotion'
Plug 'mhinz/vim-signify'
Plug 'Shougo/denite.nvim'
Plug 'SirVer/ultisnips'
Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-repeat'
Plug 'lervag/vimtex' " latex syntax highlighter

" themes
Plug 'flazz/vim-colorschemes'
Plug 'itchyny/lightline.vim'

" Add plugins to &runtimepath
call plug#end()

" Plugins Configurations
" vim-lightline
set noshowmode " use the one from lightline
let g:lightline = {
            \ 'colorscheme': 'wombat',
            \ 'active': {
            \   'left': [ [ 'mode', 'paste' ],
            \             [ 'filename', 'readonly', 'modified', 'fugitive',  'gutentags' ] ]
            \ },
            \ 'component': {
            \   'readonly': '%{&filetype=="help"?"":&readonly?"x":""}',
            \   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}',
            \   'fugitive': '%{exists("*fugitive#head")?fugitive#head():""}',
            \   'gutentags': '%{exists("*gutentags#statusline") ? gutentags#statusline("o") : ""}'
            \ },
            \ 'component_visible_condition': {
            \   'readonly': '(&filetype!="help"&& &readonly)',
            \   'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
            \   'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())',
            \   'gutentags': '(exists("*gutentags#statusline") && gutentags#statusline()!="")'
            \ },
            \ 'separator': { 'left': '', 'right': '' },
            \ 'subseparator': { 'left': '', 'right': '' }
            \ }

" UltiSnip configuration
let g:UltiSnipsSnippetsDir='~/.vim/UltiSnips'
let g:UltiSnipsSnippetDirectories=[g:UltiSnipsSnippetsDir] + ['UltiSnips']

" denite configuration
" ctrl-p like
call denite#custom#var('file_rec', 'command',
            \ ['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])
nnoremap <c-p> :Denite file_rec -updatetime=10<cr>

" vimgrep
call denite#custom#var('grep', 'command', ['ag'])
call denite#custom#var('grep', 'default_opts',
            \ ['-i', '--vimgrep', '--nocolor', '-o'])
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', [])
call denite#custom#var('grep', 'separator', ['--'])
call denite#custom#var('grep', 'final_opts', [])
call denite#custom#option('default', 'prompt', '>')
call denite#custom#map('insert', '<C-j>', '<denite:move_to_next_line>', 'noremap')
call denite#custom#map('insert', '<C-k>', '<denite:move_to_previous_line>', 'noremap')
call denite#custom#map('insert', '<C-v>', '<denite:do_action:vsplitswitch>', 'noremap')
call denite#custom#map('insert', '<C-s>', '<denite:do_action:splitswitch>', 'noremap')
nnoremap <leader>/ :Denite -updatetime=10 -no-empty grep<cr>

" Rainbow Parentheses configuration
let g:rainbow#max_level = 16
let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{', '}']]
let g:rainbow#blacklist = [233, 234]

" vim-easy-align configuration
vmap <Enter> <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" vim-easymotion configuration
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

" vim-signify configuration
let g:signify_vcs_list = [ 'git' ]

" deoplete.nvim configuration
let g:deoplete#enable_at_startup = 1
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function() abort
    return deoplete#close_popup() . "\<CR>"
endfunction

let g:deoplete#sources#clang#libclang_path = '/Library/Developer/CommandLineTools/usr/lib/libclang.dylib'
let g:deoplete#sources#clang#clang_header = '/Library/Developer/CommandLineTools/usr/lib/clang/'
let g:deoplete#sources#clang#sort_algo = 'priority'

if !exists('g:deoplete#omni#input_patterns')
    let g:deoplete#omni#input_patterns = {}
endif
let g:deoplete#omni#input_patterns.tex = '\\(?:'
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
            \ .')'

call deoplete#custom#source('_', 'matchers', ['matcher_full_fuzzy'])
call deoplete#custom#source('clang', 'rank', 1000)

" gutentags
let g:gutentags_cache_dir = '~/.cache/vim-gutentags'

" Theme configuration
set termguicolors
set background=dark

let g:gruvbox_contrast_dark = 'hard'
colorscheme gruvbox
hi link EasyMotionTarget EasyMotionTarget2FirstDefault

" Vimtex
let g:tex_flavor = 'latex'
let g:vimtex_compiler_latexmk = {
    \ 'backend' : 'nvim',
    \ 'background' : 1,
    \ 'build_dir' : 'build',
    \ 'callback' : 1,
    \ 'continuous' : 1,
    \ 'executable' : 'latexmk',
    \ 'options' : [
    \   '-pdf',
    \   '-shell-escape',
    \   '-verbose',
    \   '-file-line-error',
    \   '-synctex=1',
    \   '-interaction=nonstopmode',
    \ ],
\}

let g:vimtex_enabled = 1
let g:vimtex_view_method = 'zathura'

nmap <localleader>i <plug>(tex-iwrap-n)
nmap <localleader>b <plug>(tex-bwrap-n)
vmap <localleader>i <plug>(tex-iwrap-v)
vmap <localleader>b <plug>(tex-bwrap-v)

" Tagbar
let g:tagbar_left = 1
nnoremap <silent> <F9> :TagbarToggle<CR>


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


filetype indent plugin on " determine the type of a file based on its name
syntax enable             " depends on filetype

set hidden                " allow unsaved buffer to stay until vim closed
set showcmd               " show currently typed commands on Vim's last line
set ignorecase smartcase  " use case insensitive search, except when using capital letters
set copyindent autoindent " copy the previous indentation on autoindenting
set nostartofline         " stop certain movements from always going to the first character of a line
set title                 " change the terminal's title
set nobackup noswapfile   " don't use backup files with ~ and .swp
set ruler                 " display the cursor position on the buffer
set cursorline            " highlight line where the current cursor is in
set confirm               " raise confirmation instead failing unsaved buffer
set cmdheight=2           " set the command window height to 2 lines
set relativenumber        " display line relative numbers on the left
set nowrap                " don't wrap lines
set notimeout nottimeout  " no time out on keycodes and mappings
set list                  " show some special char to mark
set guicursor&            " reset to default neovim value (somehow it was set to nothing by default on st)
set conceallevel=1        " conceal text with appropriate conceal characeter

" map space to run command fast
noremap <Space> :
nnoremap : ,

nnoremap <Leader>l :nohl<CR><C-l>

inoremap <C-Space> <C-X><C-O>
nnoremap <Leader>st :tabe $MYVIMRC<CR>
nnoremap <Leader>sv :vsplit $MYVIMRC<CR>
nnoremap <Leader>ss :split $MYVIMRC<CR>
nnoremap <Leader>se :e $MYVIMRC<CR>

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

tnoremap <Esc> <C-\><C-n>
tnoremap <A-h> <C-\><C-n><C-w>h
tnoremap <A-j> <C-\><C-n><C-w>j
tnoremap <A-k> <C-\><C-n><C-w>k
tnoremap <A-l> <C-\><C-n><C-w>l

noremap <F10> :call colorscheme#highlight_attribute()<CR>

cnoremap w!! w !sudo tee % > /dev/null

let g:netrw_banner = 0
let g:netrw_winsize = 25
