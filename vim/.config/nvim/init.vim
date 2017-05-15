"  __   __   ___   __  __
"  \ \ / /  |_ _| |  \/  |
"   \ V /    | |  | |\/| |
"   _\_/_   |___| |_|__|_|
" _| """"|_|"""""|_|"""""|
" `-0-0-'"`-0-0-'"`-0-0-'
"
"

" ########## default ##########
filetype indent plugin on                                   " determine the type of a file based on its name
syntax enable                                               " depends on filetype

set re=1                                                    " use older version of regex engine since the new one sucks hard
set hidden                                                  " allow unsaved buffer to stay until vim closed
set showcmd                                                 " show currently typed commands on Vim's last line
set ignorecase smartcase                                    " use case insensitive search, except when using capital letters
set copyindent                                              " copy the previous indentation on autoindenting
set nostartofline                                           " stop certain movements from always going to the first character of a line
set title                                                   " change the terminal's title
set nobackup noswapfile                                     " don't use backup files with ~ and .swp
set ruler                                                   " display the cursor position on the buffer
set cursorline                                              " highlight line where the current cursor is in
set confirm                                                 " raise confirmation instead failing unsaved buffer
set cmdheight=2                                             " set the command window height to 2 lines
set relativenumber                                          " display line relative numbers on the left
set nowrap                                                  " don't wrap lines
set notimeout nottimeout                                    " no time out on keycodes and mappings
set tabstop=8 shiftwidth=8 autoindent noexpandtab           " default indentation settings.
set list                                                    " show some special char to mark
set guicursor&                                              " reset to default neovim value (somehow it was set to nothing by default on st)

" list of rc files located in the same folder as this file ($MYVIMRC)
" note: orders matters
let s:rcfiles = [
      \ 'tools.vim',
      \ 'functions.vim',
      \ 'mappings.vim',
      \ 'plugins.vim',
      \ 'autocommands.vim',
      \ 'codestyle.vim',
      \ ]

" ---------- don't peek ----------

let s:cfgdir = fnamemodify($MYVIMRC, ':p:h')
function! s:SourceRC(fname)
    source `=s:cfgdir . '/' . a:fname`
endfunction
for fname in s:rcfiles
    call s:SourceRC(fname)
endfor
