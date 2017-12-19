" vim-plug configuration 
call plug#begin('~/.config/nvim/bundle')

" ##### completion #####
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' } " autocomplete
Plug 'zchee/deoplete-clang' " deoplete source for C/C++
Plug 'Shougo/neoinclude.vim' " source from included file (C/C++)
Plug 'zchee/deoplete-jedi' " deoplete source for Python

" #### ftplugins ####
Plug 'lervag/vimtex' " latex syntax highlighter
Plug 'sheerun/vim-polyglot'

" #### code ####
Plug 'ludovicchabant/vim-gutentags' " auto (re)generate ctag file
Plug 'junegunn/rainbow_parentheses.vim' " colorize parentheses
Plug 'Raimondi/delimitMate' " autocomplete brackets, parentheses
Plug 'vim-scripts/matchit.zip' " % match tag in html
Plug 'vim-scripts/taglist.vim' " taglist browser for many different languages
Plug 'sukima/xmledit' " edit xml
Plug 'tpope/vim-commentary' " comments with gc<movement>
Plug 'tpope/vim-surround' " surround command

" ##### utilities #####
Plug 'easymotion/vim-easymotion'
Plug 'mhinz/vim-signify'
Plug 'vimwiki/vimwiki'
Plug 'Shougo/denite.nvim'
Plug 'SirVer/ultisnips'
Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-dispatch'

" ##### themes #####
Plug 'flazz/vim-colorschemes'
Plug 'itchyny/lightline.vim'

" Add plugins to &runtimepath
call plug#end()

" ######################### Plugins Configurations #########################
" ##### vim-lightline #####
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
            \   'gutentags': '%{gutentags#statusline("o")}'
            \ },
            \ 'component_visible_condition': {
            \   'readonly': '(&filetype!="help"&& &readonly)',
            \   'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
            \   'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())',
            \   'gutentags': '(gutentags#statusline()!="")'
            \ },
            \ 'separator': { 'left': '⮀', 'right': '⮂' },
            \ 'subseparator': { 'left': '|', 'right': '|' }
            \ }

" ##### UltiSnip configuration #####
let g:UltiSnipsSnippetsDir='~/.vim/UltiSnips'
let g:UltiSnipsSnippetDirectories=[g:UltiSnipsSnippetsDir] + ["UltiSnips"]

" ##### filetype plugin #####
let g:tex_flavor = 'latex'

" ##### denite configuration #####
call denite#custom#var('file_rec', 'command',
            \ ['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])

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
nnoremap <c-p> :Denite file_rec -updatetime=10<cr>
nnoremap <leader>/ :Denite -updatetime=10 -no-empty grep<cr>

" #### Rainbow Parentheses configuration ####
call init#fthook(['c','c++'], 'RainbowParentheses') " activate for C/C++
let g:rainbow#max_level = 16
let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{', '}']]
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

let g:deoplete#sources#clang#libclang_path = '/usr/lib/libclang.so'
let g:deoplete#sources#clang#clang_header = '/usr/lib/clang/'

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

" ##### Theme configuration #####
set termguicolors
set background=dark

let g:gruvbox_contrast_dark = "hard"
colorscheme gruvbox
hi link EasyMotionTarget EasyMotionTarget2FirstDefault

" ##### Vimtex #####
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


" ##### Vimwiki #####
nmap <Leader>wls <Plug>VimwikiSplitLink
nmap <Leader>wlv <Plug>VimwikiVSplitLink
let g:vimwiki_list = [{
            \ 'path': '~/vimwiki/',
            \ 'template_path': '~/vimwiki/templates/',
            \ 'template_default': 'vimwiki',
            \ 'template_ext': '.html'
            \ }]
