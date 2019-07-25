" config {{{1
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
set shortmess+=c
set foldmethod=marker

let mapleader = ','

" map space to run command fast
noremap <Space> :
nnoremap : ,

nnoremap <Leader>l :nohl<CR><C-l>
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

noremap <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
            \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
            \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

cnoremap w!! w !sudo tee % > /dev/null

" vim-plug {{{1
if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.cache/nvim-plugins')
Plug 'junegunn/vim-plug'

" completion
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' } " autocomplete
" c/c++/objc completion
Plug 'Shougo/neoinclude.vim' " source from included file (C/C++)

" haskell completion
Plug 'eagletmt/neco-ghc'

" python completion
Plug 'zchee/deoplete-jedi' " deoplete source for Python
Plug 'numirias/semshi', { 'do': ':UpdateRemotePlugins' } " semantic syntax highlight

" go completion
Plug 'zchee/deoplete-go', { 'do': 'make' }
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" code
Plug 'neomake/neomake'
Plug 'sbdchd/neoformat'
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
Plug 'SirVer/ultisnips'
Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'lervag/vimtex' " latex syntax highlighter
Plug 'airblade/vim-rooter'

" themes
Plug 'flazz/vim-colorschemes'
Plug 'itchyny/lightline.vim'

" Add plugins to &runtimepath
call plug#end()

" Plugins Configurations
" vim-plug
nnoremap <Leader>pu :PlugUpdate<CR>
nnoremap <Leader>pU :PlugUpgrade<CR>
nnoremap <Leader>pc :PlugClean<CR>
nnoremap <Leader>pi :PlugInstall<CR>

" neoformat {{{1
augroup neoformat
    autocmd!
augroup END

" neomake {{{1
call neomake#configure#automake('w')
let g:neomake_open_list = 2
let g:neomake_error_sign = { 'text': '✗', 'texthl': 'NeomakeErrorSign' }
let g:neomake_warning_sign = { 'text': '‼', 'texthl': 'NeomakeWarningSign' }
let s:options = {
            \ 'common': [ '-DDEBUG', '-Wall', '-Wextra', '-pedantic', '-std=c++17', '-Wshadow', '-Wfloat-equal', '-Wconversion',
            \             '-Wlogical-op', '-Wshift-overflow=2', '-Wduplicated-cond', '-Wcast-qual', '-Wcast-align' ]
            \ }

let g:neomake_cpp_compile_maker = {
            \ 'exe': 'g++',
            \ 'args': s:options.common + [ '-ggdb', '-o', 'raw' ],
            \ }

let g:neomake_cpp_optimize_maker = {
            \ 'exe': 'g++',
            \ 'args': s:options.common + [ '-O2', '-o', 'fast' ],
            \ }

let g:neomake_cpp_sanitize_maker = {
            \ 'exe': 'g++',
            \ 'args': s:options.common + ['-D_GLIBCXX_DEBUG', '-D_GLIBCXX_DEBUG_PEDANTIC', '-D_FORTIFY_SOURCE=2',
            \          '-fsanitize=address', '-fsanitize=undefined', '-fno-sanitize-recover', '-fstack-protector',
            \          '-O2', '-o', 'sane' ],
            \ }

let g:neomake_cpp_enabled_makers = ['compile', 'optimize', 'sanitize']

augroup neomake_quickfix
    autocmd!
    autocmd QuitPre * if &filetype !=# 'qf' | lclose | endif
augroup END

" UltiSnip {{{1
let g:UltiSnipsSnippetsDir = '~/.config/nvim/UltiSnips'
let g:UltiSnipsSnippetDirectories = [g:UltiSnipsSnippetsDir] + ['UltiSnips']

" rainbow_parentheses {{{1
augroup rainbow_parentheses
    autocmd FileType * RainbowParentheses
augroup END

let g:rainbow#max_level = 16
let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{', '}']]
let g:rainbow#blacklist = [233, 234]

" vim-easy-align {{{1
vmap <Enter> <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" vim-easymotion {{{1
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

" vim-signify {{{1
let g:signify_vcs_list = [ 'git' ]

" deoplete.nvim {{{1
set completeopt+=noinsert,noselect
set completeopt-=preview
let g:deoplete#enable_at_startup = 1
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function() abort
    return deoplete#close_popup() . "\<CR>"
endfunction
let g:deoplete#omni_patterns = {}
let g:deoplete#omni#input_patterns = {}


call deoplete#custom#source('_', 'matchers', ['matcher_full_fuzzy'])

" gutentags {{{1
let g:gutentags_cache_dir = '~/.cache/vim-gutentags'
let g:gutentags_exclude = [
            \ '*.css', '*.html', '*.js', '*.json', '*.xml',
            \ '*.rst', '*.md',
            \ ]
let g:gutentags_file_list_command = {
            \ 'markers': {
            \ '.git': 'git ls-files',
            \ '.hg': 'hg files',
            \ },
            \ }

" theme {{{1
set termguicolors
set background=dark

let g:gruvbox_contrast_dark = 'medium'
colorscheme gruvbox
hi link EasyMotionTarget EasyMotionTarget2FirstDefault

" vimtex {{{1
let g:tex_conceal = 'abdmg'
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
let g:vimtex_quickfix_mode = 0
let g:vimtex_view_method = 'zathura'

nmap <localleader>i <plug>(tex-iwrap-n)
nmap <localleader>b <plug>(tex-bwrap-n)
vmap <localleader>i <plug>(tex-iwrap-v)
vmap <localleader>b <plug>(tex-bwrap-v)

" tagbar {{{1
let g:tagbar_left = 1
nnoremap <silent> <F10> :TagbarToggle<CR>

" vim-rooter {{{1
let g:rooter_manual_only = 1

" vim-lightline {{{1
set noshowmode " use the one from lightline

function! LightlineNeomake()
    let bufnr = bufnr('%')
    let running_jobs = filter(copy(neomake#GetJobs()),
                \ "v:val.bufnr == bufnr  && !get(v:val, 'canceled', 0)")
    if empty(running_jobs)
        return '✓'
    else
        return '⟳ ' . join(map(running_jobs, 'v:val.name'), ', ')
    endif
endfunction

function! LightlineFugitive()
    return fugitive#head()
endfunction

function! LightlineGutentags()
    return gutentags#statusline()
endfunction

let g:lightline = {}
let g:lightline.enable = {
            \   'statusline': 1,
            \   'tabline':    0,
            \ }

let g:lightline.colorscheme = 'wombat'
let g:lightline.active = {
            \   'left':  [ [ 'mode', 'paste' ],
            \             [ 'filename', 'readonly', 'modified', ],
            \             [ 'fugitive',  'neomake' ] ],
            \   'right': [ [ 'lineinfo' ],
            \              [ 'percent' ],
            \              [ 'fileformat', 'fileencoding', 'filetype' ],
            \              [ 'gutentags' ] ]
            \ }

let g:lightline.component = {
            \   'readonly': '%{&filetype == "help" ? "" : &readonly ? "x" :""}',
            \   'modified': '%{&filetype == "help" ? "" : &modified ? "+" : &modifiable? "" : "-"}',
            \ }

let  g:lightline.component_expand = {
            \   'fugitive':  'LightlineFugitive',
            \   'neomake':   'LightlineNeomake',
            \   'gutentags': 'LightlineGutentags',
            \ }

let g:lightline.separator    = { 'left': '', 'right': '' }
let g:lightline.subseparator = { 'left': '', 'right': '' }

augroup lightline_update
    autocmd!
    autocmd User NeomakeJobStarted call lightline#update()
    autocmd User NeomakeJobFinished call lightline#update()
    autocmd User GutentagsUpdating call lightline#update()
    autocmd User GutentagsUpdated call lightline#update()
augroup END

" cscope {{{1
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

    nnoremap <Leader>cs :cs find s <C-R><C-W><CR>
    nnoremap <Leader>cg :cs find g <C-R><C-W><CR>
    nnoremap <Leader>cc :cs find c <C-R><C-W><CR>
    nnoremap <Leader>ct :cs find t <C-R><C-W><CR>
    nnoremap <Leader>ce :cs find e <C-R><C-W><CR>
    nnoremap <Leader>cf :cs find f <C-R><C-F><CR>
    nnoremap <Leader>ci :cs find i ^<C-R><C-F>$<CR>
    nnoremap <Leader>cd :cs find d <C-R><C-W><CR>
    nnoremap <Leader>ca :cs find a <C-R><C-W><CR>
endif

