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
Plug 'vim-scripts/matchit.zip' " % match tag in html
Plug 'sukima/xmledit' " edit xml
Plug 'zah/nim.vim' " nim language syntax highlighter
Plug 'lervag/vimtex' " latex syntax highlighter
Plug 'vim-scripts/taglist.vim' " taglist browser for many different languages
Plug 'ludovicchabant/vim-gutentags'
Plug 'Rip-Rip/clang_complete'

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

" ##### clang_complete configuration ####
let g:clang_complete_auto = 0
let g:clang_auto_select = 0
let g:clang_omnicppcomplete_compliance = 0
let g:clang_make_default_keymappings = 0
let g:clang_debug = 0
let g:clang_use_library = 1

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
