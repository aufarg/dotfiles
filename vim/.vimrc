"  __   __   ___   __  __
"  \ \ / /  |_ _| |  \/  |
"   \ V /    | |  | |\/| |
"   _\_/_   |___| |_|__|_|
" _| """"|_|"""""|_|"""""|
" `-0-0-'"`-0-0-'"`-0-0-'
"
"
" ######################### vimrc index  #########################
" 1. Vim Configurations
" 2. Custom Functions
" 3. Plugins
" 4. Plugins Configurations
" 5. Autocommands
" ################################################################


" ######################### Vim Configurations #########################
" Attempt to determine the type of a file based on its name this will make
" sure syntax highlight got it right
filetype indent plugin on

" Use older version of regex engine since the new one sucks hard
set re=1

" Enable omnicomplete
set omnifunc=syntaxcomplete#Complete

" Enable syntax highlighting
syntax enable

" Allow unsaved buffer to stay until vim closed because tabs sucks
set hidden

" Show currently typed commands on Vim's last line
set showcmd

" Use case insensitive search, except when using capital letters
set ignorecase smartcase

" Copy the previous indentation on autoindenting
set copyindent

" Stop certain movements from always going to the first character of a line.
set nostartofline

" Change the terminal's title
set title

" Don't use backup files with ~ and .swp, it's disgusting
set nobackup noswapfile

" Display the cursor position on the last line of the screen or in the status
" line of a window
set ruler

" Highlight line where the current cursor is in
set cursorline

" Instead of failing a command because of unsaved changes, instead raise a
" dialogue asking if you wish to save changed files.
set confirm

" Set the command window height to 2 lines, to avoid many cases of having to
" "press <Enter> to continue"
set cmdheight=2

" Display line relative numbers on the left
set relativenumber

" Don't wrap lines, it's confusing
set nowrap

" Quickly time out on keycodes, but never time out on mappings
set notimeout nottimeout

" Remove scratch preview pane
set completeopt-=preview

" Default indentation settings for using 4-spaced tabs.
set tabstop=8 shiftwidth=4 smartindent expandtab

" Show some special char to mark
set list

" ######################### Custom Functions #########################
" Initialize HTML filetype options
function! InitHTML()
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

" ######################### Key Mappings #########################
" Map space to run command fast
noremap <Space> :
noremap q<Space> q:

" Now we can bind ':' as inverse of ';', which is ','
nnoremap : ,

" And let ',' be mapleader, since ',' is easier than '\'
let mapleader = ','

" #### Leader Map ####
" Map to ReFresh screen
nnoremap <Leader>rf :nohl<CR><C-l>

" Map to open $MYVIMRC fast
nnoremap <Leader>vconf :vsplit $MYVIMRC<CR>
nnoremap <Leader>sconf :split $MYVIMRC<CR>
nnoremap <Leader>conf :e $MYVIMRC<CR>

" Easy window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Change completion trigger
inoremap <C-Space> <C-X><C-O>

" Remap number increment and decrement to alt
nnoremap <A-a> <C-a>
nnoremap <A-x> <C-x>

" Determine highlight group
noremap <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
            \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
            \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" Oops! Forgot to sudo
cnoremap w!! w !sudo tee % > /dev/null

" ######################### Plugins #########################
" vim-plug configuration 
call plug#begin('~/.config/nvim/bundle')

" ##### Superb Plugins (god-like utilities) #####
Plug 'terryma/vim-multiple-cursors'
Plug 'easymotion/vim-easymotion'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'rking/ag.vim'
Plug 'ervandew/supertab'
Plug 'SirVer/ultisnips'

" ##### Code #####
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'Raimondi/delimitMate'
Plug 'Shougo/deoplete.nvim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'matchit.zip'
Plug 'sukima/xmledit'
Plug 'zah/nim.vim'
Plug 'lervag/vimtex'
Plug 'xolox/vim-easytags'
Plug 'xolox/vim-misc'
Plug 'taglist.vim'

" ##### Misc (add-ons) #####
Plug 'lilydjwg/colorizer'
Plug 'junegunn/vim-easy-align'
Plug 'kshenoy/vim-signature'
Plug 'mhinz/vim-signify'
Plug 'vimwiki/vimwiki'

" ##### Themes #####
Plug 'flazz/vim-colorschemes'

" Add plugins to &runtimepath
call plug#end()

" ######################### Plugins Configurations #########################
" ##### UltiSnip configuration #####
let g:UltiSnipsSnippetsDir='~/.vim/UltiSnips'
let g:UltiSnipsSnippetDirectories=[g:UltiSnipsSnippetsDir] + ["UltiSnips"]

" ##### filetype plugin #####
let g:tex_flavor = 'latex'

" ##### netrw configuration #####
let g:netrw_liststyle = 3
let g:netrw_banner = 0

" ##### CtrlSpace configuration #####
if &runtimepath =~ "CtrlSpace"
    set showtabline=0
    if executable("ag")
        let g:CtrlSpaceGlobCommand = 'ag -l --nocolor -g ""'
    endif
    let g:CtrlSpaceLoadLastWorkspaceOnStart = 1
    let g:CtrlSpaceSaveWorkspaceOnSwitch = 1
    let g:CtrlSpaceSaveWorkspaceOnExit = 1
endif

" ##### ctrlp configuration #####
let g:ctrlp_extensions = ['tag']


" ##### colorizer configuration #####
if &runtimepath =~ "colorizer"
    let g:colorizer_startup = 0
endif

" #### Rainbow Parentheses configuration ####
if &runtimepath =~ "rainbow_parentheses"
    let g:rainbow#max_level = 16
    let g:rainbow#pairs = [['(', ')'], ['[', ']']]

    " list of colors that you do not want. ANSI code or #RRGGBB
    let g:rainbow#blacklist = [233, 234]
    if has("autocmd")
        aug rainbow_parentheses
            au VimEnter * RainbowParentheses
        aug END
    endif
endif

" #### vim-easy-align configuration ####
if &runtimepath =~ "vim-easy-align"
    " Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
    vmap <Enter> <Plug>(EasyAlign)

    " Start interactive EasyAlign for a motion/text object (e.g. gaip)
    nmap ga <Plug>(EasyAlign)
endif

" #### vim-easytags configuration ####
if &runtimepath =~ "vim-easytags"
    let g:easytags_async = 1
endif

" #### vim-easymotion configuration ####
if &runtimepath =~ "vim-easymotion"
    let g:EasyMotion_smartcase = 1
    let g:EasyMotion_use_upper = 1
    let g:EasyMotion_do_mapping = 0
    let g:EasyMotion_keys = 'hjklyuiopnm,qweasdzxcrtfgvb;r'

    " change f and t to use easymotion
    map f <Plug>(easymotion-fl)
    map F <Plug>(easymotion-Fl)
    map t <Plug>(easymotion-tl)
    map T <Plug>(easymotion-Tl)

    " change s to multi input search anywhere
    map s <Plug>(easymotion-s2)

    " next and prev using easy motion
    map ; <Plug>(easymotion-next)
    map : <Plug>(easymotion-prev)
endif

" #### vim-signify configuration ####
if &runtimepath =~ 'vim-signify'
    let g:signify_vcs_list = [ 'git' ]
endif

" ##### deoplete.nvim configuration ####
" Use deoplete.
if &runtimepath =~ 'deoplete.nvim'
    if &runtimepath =~ 'supertab'
        let g:SuperTabDefaultCompletionType = "context"
        let g:SuperTabContextDefaultCompletionType = "<c-n>"
    endif
    let g:deoplete#enable_at_startup = 1
endif


" ##### Theme configuration #####
if &runtimepath =~ "vim-colorschemes"
    let $NVIM_TUI_ENABLE_TRUE_COLOR = 1
    set background=dark
    colorscheme gruvbox
    hi link EasyMotionTarget EasyMotionTarget2FirstDefault
    hi gitcommitSelectedFile ctermfg=142
endif

" ##### Vimtex #####
if &runtimepath =~ "vimtex"
    let g:vimtex_latexmk_options = '-pdf -verbose -file-line-error -synctex=1 -interaction=nonstopmode -xelatex'
    let g:vimtex_enabled = 1
    let g:vimtex_view_method = 'zathura'
    let g:vimtex_latexmk_build_dir = 'build'
    if &runtimepath =~ 'deoplete.nvim'
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
                    \ .')'

    endif
endif


if &runtimepath =~ "vimwiki"
    nmap <Leader>wls <Plug>VimwikiSplitLink
    nmap <Leader>wlv <Plug>VimwikiVSplitLink
    let g:vimwiki_list = [{
                \ 'path': '~/vimwiki/',
                \ 'template_path': '~/vimwiki/templates/',
                \ 'template_default': 'vimwiki',
                \ 'template_ext': '.html' }]
endif

" ######################### Autocommands #########################
if has("autocmd")
    " Syntax highlights groups
    aug syntax_highlights
        au!
        au FileType html call InitHTML()
    aug END

    " Auto-source files to current session after write
    aug auto_sources
        au! 
        au BufWritePost ~/.vim/init.vim source $MYVIMRC
        au BufWritePost ~/.config/nvim/init.vim source $MYVIMRC
    aug END

    " Completion depending on filetype
    aug completions
        au FileType php setlocal omnifunc=phpcomplete#CompletePHP
        au FileType css setlocal omnifunc=csscomplete#CompleteCSS
        au FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
        au FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
        au FileType python setlocal omnifunc=pythoncomplete#Complete
        au FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
    aug END

    " Indentation depending on filetype
    aug indentations
        au FileType python setlocal tabstop=4 softtabstop=4 shiftwidth=4 textwidth=80 smarttab expandtab
    aug END

    " Mutt Filetype (vim has muttrc syntax highlight, sadly the config doesn't
    " have the extension required)
    aug set_filetypes
        au BufRead /tmp/mutt-* setlocal tw=72
        au BufRead ~/.mutt/* setlocal filetype=muttrc
    aug END

    " Latex autocommand
    aug latex
        au FileType tex nnoremap <silent> <LocalLeader>i :<C-U>set operatorfunc=LatexItalicize<CR>g@
        au FileType tex vnoremap <silent> <LocalLeader>i :<C-U>call LatexItalicize(visualmode())<CR>
        au FileType tex nnoremap <silent> <LocalLeader>b :<C-U>set operatorfunc=LatexBold<CR>g@
        au FileType tex vnoremap <silent> <LocalLeader>b :<C-U>call LatexBold(visualmode())<CR>
    aug END

    " Mail settings
    aug mail
        au FileType mail source ~/.mutt/mail-vimrc
        au FileType mail setlocal fo+=aw
    aug END
endif
