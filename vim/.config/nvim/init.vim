" Vim Configurations: {{{1
" ========================

" ------------------------
" Option: {{{2
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
set listchars+=extends:❯  " show markers on the right for trimmed-line when wrap is unset
set listchars+=precedes:❮ " show markers on the left for trimmed-line when wrap is unset
set guicursor&            " reset to default neovim value (somehow it was set to nothing by default on st)
set conceallevel=1        " conceal text with appropriate conceal characeter
set scrolloff=4           " minimum number of lines above and below the cursor (start and end line excluded)
set sidescrolloff=8       " minimum number of columns left and right the cursor (start and end column excluded)
set autowrite
set autoread
set shortmess+=c
set foldmethod=marker
set tagcase=followscs

set completeopt+=noinsert,noselect
set completeopt-=preview

set mouse=nv

set path=.

set grepprg=ag\ --vimgrep\ $*
set grepformat=%f:%l:%c:%m

set termguicolors

" ------------------------
" Function: {{{2
" functions to edit configuration files
function! s:configure_ft_plugin(ft)
    if !empty(a:ft)
        let type = a:ft
    elseif !empty(&filetype)
        let type = &filetype
    else
        return
    endif

    let path = s:config_directory() . '/after/ftplugin/' . type . '.vim'
    execute 'edit ' . path
endfunction

function! s:config_directory()
    return fnamemodify(expand($MYVIMRC), ':h')
endfunction

function! s:configure_vimrc()
    execute 'edit $MYVIMRC'
endfunction

" Mapping: {{{2
let mapleader = ','

" map space to run command fast
noremap <Space> :
nnoremap : ,

nnoremap <Leader>l :nohl<CR><C-l>
nnoremap <Leader>f :find *
nnoremap <Leader>b :buf *
nnoremap <Leader>g :ls<CR>:b<Space>

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

nnoremap n nzzzv
nnoremap N Nzzzv

tnoremap <Esc> <C-\><C-n>
tnoremap <A-h> <C-\><C-n><C-w>h
tnoremap <A-j> <C-\><C-n><C-w>j
tnoremap <A-k> <C-\><C-n><C-w>k
tnoremap <A-l> <C-\><C-n><C-w>l

noremap <silent> <F8> :Neomake! test<CR>
noremap <silent> <F9> :Neomake! build<CR>

noremap <silent> <F12> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
            \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
            \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

cnoremap w!! w !sudo tee % > /dev/null

" Command: {{{2

command! Scratch vnew | setlocal nobuflisted buftype=nofile bufhidden=wipe noswapfile

" edit configuration files
command! -nargs=? Eft call s:configure_ft_plugin(<q-args>)
command! Erc call s:configure_vimrc()


" ------------------------
" Autocommand: {{{2
augroup focus_lost
    au!
    au FocusLost * :silent! wall
augroup END

augroup cursor_line
    au!
    au WinLeave,InsertEnter * set nocursorline
    au WinEnter,InsertLeave * set cursorline
augroup END

augroup line_return
    au!
    au BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \     execute 'normal! g`"zvzz' |
        \ endif
augroup END

augroup close_quickfix_on_buffer_close
    autocmd!
    autocmd QuitPre * if &filetype !=# 'qf' | lclose | endif
augroup END

" Plugins Configurations: {{{1
" ========================

" ------------------------
" vimplug {{{2
if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.cache/nvim-plugins')
Plug 'junegunn/vim-plug'

" haskell completion
Plug 'neovimhaskell/haskell-vim'

" go completion
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" code
Plug 'neomake/neomake'
Plug 'sbdchd/neoformat'
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
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-unimpaired'
Plug 'lervag/vimtex' " latex syntax highlighter
Plug 'airblade/vim-rooter'

" themes
Plug 'joshdick/onedark.vim'
Plug 'itchyny/lightline.vim'

Plug 'neovim/nvim-lspconfig'

" Add plugins to &runtimepath
call plug#end()

" Plugins Configurations
" vim-plug
nnoremap <Leader>pu :PlugUpdate<CR>
nnoremap <Leader>pU :PlugUpgrade<CR>
nnoremap <Leader>pc :PlugClean<CR>
nnoremap <Leader>pi :PlugInstall<CR>

" ------------------------
" neoformat {{{2
augroup neoformat
    autocmd!
augroup END

" ------------------------
" neomake {{{2
call neomake#configure#automake('w')
let g:neomake_open_list = 2
let g:neomake_error_sign = { 'text': '✗', 'texthl': 'NeomakeErrorSign' }
let g:neomake_warning_sign = { 'text': '‼', 'texthl': 'NeomakeWarningSign' }
func! Code(ops)
    execute "Neomake! " . a:ops
endfunc
" ------------------------
" neomake makers: haskell {{{3
let g:neomake_haskell_enabled_makers = ['liquid']
let g:neomake_haskell_build_maker = {
            \ 'exe': 'stack',
            \ 'args': ['build']
            \ }
let g:neomake_haskell_test_maker = {
            \ 'exe': 'stack',
            \ 'args': ['test']
            \ }
" ------------------------
" neomake makers: competitive programming {{{3
let g:neomake_cpp_enabled_makers = ['lint']
let s:neomake_cpp_maker_options = {
            \ 'common': [ '-DDEBUG', '-Wall', '-Wextra', '-pedantic', '-std=c++17', '-Wshadow', '-Wfloat-equal', '-Wconversion',
            \             '-Wlogical-op', '-Wshift-overflow=2', '-Wduplicated-cond', '-Wcast-qual', '-Wcast-align' ]
            \ }

let g:neomake_cpp_lint_maker = {
            \ 'exe': 'g++',
            \ 'args': s:neomake_cpp_maker_options.common + [ '-ggdb', '-o', '%' ],
            \ }
let g:neomake_cpp_compile_maker = {
            \ 'exe': 'g++',
            \ 'args': s:neomake_cpp_maker_options.common + ['-D_GLIBCXX_DEBUG', '-D_GLIBCXX_DEBUG_PEDANTIC', '-D_FORTIFY_SOURCE=2',
            \          '-fsanitize=address', '-fsanitize=undefined', '-fno-sanitize-recover', '-fstack-protector',
            \          '-O2', '-o', 'sane' ],
            \ }
" ------------------------
" UltiSnip {{{2
let g:UltiSnipsExpandTrigger = "<C-Space>"
let g:UltiSnipsSnippetsDir = '~/.config/nvim/UltiSnips'
let g:UltiSnipsSnippetDirectories = [g:UltiSnipsSnippetsDir] + ['UltiSnips']

" ------------------------
" rainbow_parentheses {{{2
augroup rainbow_parentheses
    autocmd FileType * RainbowParentheses
augroup END

let g:rainbow#max_level = 16
let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{', '}']]
let g:rainbow#blacklist = [233, 234]

" ------------------------
" vim-easy-align {{{2
vmap <Enter> <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" ------------------------
" vim-easymotion {{{2
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

" ------------------------
" vim-signify {{{2
let g:signify_vcs_list = [ 'git' ]

" ------------------------
" ------------------------
" theme {{{2
colorscheme onedark
hi link EasyMotionTarget EasyMotionTarget2FirstDefault

" ------------------------
" vimtex {{{2
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

" ------------------------
" tagbar {{{2
let g:tagbar_left = 1
nnoremap <silent> <F10> :TagbarToggle<CR>

" ------------------------
" vim-rooter {{{2
let g:rooter_manual_only = 1

" ------------------------
" vim-lightline {{{2
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

let g:lightline = {}
let g:lightline.enable = {
            \   'statusline': 1,
            \   'tabline':    0,
            \ }

let g:lightline.colorscheme = 'onedark'
let g:lightline.active = {
            \   'left':  [ [ 'mode', 'paste' ],
            \             [ 'filename', 'readonly', 'modified', ],
            \             [ 'fugitive',  'neomake' ] ],
            \   'right': [ [ 'lineinfo' ],
            \              [ 'percent' ],
            \              [ 'fileformat', 'fileencoding', 'filetype' ] ],
            \ }

let g:lightline.component = {
            \   'readonly': '%{&filetype == "help" ? "" : &readonly ? "x" :""}',
            \   'modified': '%{&filetype == "help" ? "" : &modified ? "+" : &modifiable? "" : "-"}',
            \ }

let  g:lightline.component_expand = {
            \   'fugitive':  'LightlineFugitive',
            \   'neomake':   'LightlineNeomake',
            \ }

let g:lightline.separator    = { 'left': '', 'right': '' }
let g:lightline.subseparator = { 'left': '', 'right': '' }

augroup lightline_update
    autocmd!
    autocmd User NeomakeJobStarted call lightline#update()
    autocmd User NeomakeJobFinished call lightline#update()
augroup END

" ------------------------
" nvim-lspconfig {{{2

lua << EOF
local lspconfig = require('lspconfig')

-- C/C++
lspconfig.clangd.setup{}

-- Haskell
lspconfig.hls.setup{
  filetypes = { 'haskell', 'lhaskell', 'cabal' },
}

-- LaTeX
lspconfig.texlab.setup{}

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<Leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<Leader>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<Leader>cd', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<Leader>cr', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<Leader>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<Leader>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})
EOF
