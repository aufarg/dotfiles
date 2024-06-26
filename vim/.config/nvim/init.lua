-- Vim Configurations: {{{1
-- ========================

--------------------------
-- Option {{{2
vim.opt.hidden          = true       -- allow unsaved buffer to stay until vim closed
vim.opt.showcmd         = true       -- show currently typed commands on Vim's last line
vim.opt.ignorecase      = true       -- use case insensitive search, except when using capital letters
vim.opt.smartcase       = true
vim.opt.copyindent      = true       -- copy the previous indentation on autoindenting
vim.opt.autoindent      = true
vim.opt.startofline     = false      -- stop certain movements from always going to the first character of a line
vim.opt.title           = true       -- change the terminal's title
vim.opt.backup          = false      -- don't use backup files with ~ and .swp
vim.opt.swapfile        = false      -- don't use backup files with ~ and .swp
vim.opt.ruler           = true       -- display the cursor position on the buffer
vim.opt.cursorline      = true       -- highlight line where the current cursor is in
vim.opt.confirm         = true       -- raise confirmation instead failing unsaved buffer
vim.opt.cmdheight       = 2          -- set the command window height to 2 lines
vim.opt.relativenumber  = true       -- display line relative numbers on the left
vim.opt.wrap            = false      -- don't wrap lines
vim.opt.timeout         = false      -- no time out on keycodes and mappings
vim.opt.ttimeout        = false      -- no time out on keycodes and mappings
vim.opt.list            = true       -- show some special char to mark
vim.opt.listchars:append { extends = '❯'}  -- show markers on the right for trimmed-line when wrap is unset
vim.opt.listchars:remove { precedes = '❮'} -- show markers on the left for trimmed-line when wrap is unset
vim.opt.conceallevel    = 1          -- conceal text with appropriate conceal characeter
vim.opt.scrolloff       = 4          -- minimum number of lines above and below the cursor (start and end line excluded)
vim.opt.sidescrolloff   = 8          -- minimum number of columns left and right the cursor (start and end column excluded)
vim.opt.autowrite       = true -- auto write when changing buffers with certain commands
vim.opt.autoread        = true -- auto read when changing buffers with certain commands
vim.opt.shortmess:append 'c'
vim.opt.foldmethod      = 'marker'
vim.opt.tagcase         = 'followscs'

vim.opt.completeopt:append {'noinsert','noselect'}
vim.opt.completeopt:remove {'preview'}

vim.opt.mouse           = 'nv'

vim.opt.path            = '.'

vim.opt.grepprg         = 'ag --vimgrep $*'
vim.opt.grepformat      = '%f:%l:%c:%m'

vim.opt.termguicolors   = true
vim.opt.mmp             = 10000

---------------------------
-- Function {{{2
-- functions to edit configuration files
local get_vimrc_path = function()
  return vim.env.MYVIMRC
end

local get_config_directory = function()
    return vim.fn.fnamemodify(vim.fn.expand(get_vimrc_path()), ':h')
end

edit_vimrc = function()
    vim.cmd.edit(get_vimrc_path())
end

edit_ftplugin = function(ft)
  local optft = vim.opt.filetype:get()
  local type
  if ft ~= nil then
      type = ft
  elseif optft ~= nil then
      type = optft
  else
      return
  end

  local path = vim.fs.joinpath(get_config_directory(), '/after/ftplugin/', type .. '.lua')
  vim.cmd.edit(path)
end

-- Mapping {{{2
vim.g.mapleader = ','
vim.keymap.set('n', '<Space>', ':')
vim.keymap.set('n', ':', ',')

vim.keymap.set('n', '<Leader>l', ':nohl<CR><C-l>')
vim.keymap.set('n', '<Leader>f', ':find *')
vim.keymap.set('n', '<Leader>b', ':buf *')
-- vim.keymap.set('n', '<Leader>g', ':ls<CR>:b<Space>')

vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-l>', '<C-w>l')

vim.keymap.set('n', 'n', 'nzvzz')
vim.keymap.set('n', 'N', 'Nzvzz')

-- tnoremap <Esc> <C-\><C-n>
-- tnoremap <A-h> <C-\><C-n><C-w>h
-- tnoremap <A-j> <C-\><C-n><C-w>j
-- tnoremap <A-k> <C-\><C-n><C-w>k
-- tnoremap <A-l> <C-\><C-n><C-w>l
--
--
-- noremap <silent> <F12> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
--             \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
--             \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
-- 
-- cnoremap w!! w !sudo tee % > /dev/null

-- Command {{{2

-- vim.api.nvim_create_user_command('Scratch', 'vnew | setlocal nobuflisted buftype=nofile bufhidden=wipe noswapfile', { force = true })
-- command! Scratch vnew | setlocal nobuflisted buftype=nofile bufhidden=wipe noswapfile

open_scratch = function()
  local buf = vim.api.nvim_create_buf(false, true)
  local win = vim.api.nvim_open_win(buf, false, {
    split = 'above',
    win = 0
  })
end

-- Grep {{{2
vim.keymap.set('ca', 'grep', function()
  return ((vim.fn['getcmdtype']() == ':' and vim.fn['getcmdline']() == 'grep') and 'silent grep!') or 'grep'
end , { expr = true })

-- Auto-open QF window
vim.api.nvim_create_autocmd({'QuickFixCmdPost'}, {
  group = vim.api.nvim_create_augroup('quickfix', { clear = true }),
  pattern = '[^l]*',
  callback = function(ev)
    vim.cmd.cwindow()
  end
})

-- edit configuration files
-- command! -nargs=? Eft call s:configure_ft_plugin(<q-args>)
-- command! Erc call s:configure_vimrc()

-- Autocommand {{{2
vim.api.nvim_create_autocmd({'FocusLost'}, {
  group = vim.api.nvim_create_augroup('SaveOnFocusLost', {}),
  pattern = '*',
  command = ':silent! wall'
})

do
  local group = vim.api.nvim_create_augroup('ToggleCursorLineOnWindowChange', {})
  vim.api.nvim_create_autocmd({'WinLeave', 'InsertEnter'}, {
    group = group,
    pattern = '*',
    command = 'set nocursorline'
  })
  vim.api.nvim_create_autocmd({'WinEnter', 'InsertLeave'}, {
    group = group,
    pattern = '*',
    command = 'set cursorline'
  })
end

vim.api.nvim_create_autocmd({'BufReadPost'}, {
  group = vim.api.nvim_create_augroup('CenterLastOpenedLine', {}),
  pattern = '*',
  callback = function(ev)
    vim.cmd.normal { args = {'g`"zvzz'}, bang = true }
  end
})

vim.api.nvim_create_autocmd({'QuitPre'}, {
  group = vim.api.nvim_create_augroup('CloseQFOnQuit', {}),
  pattern = '*',
  callback = function(ev)
    if vim.opt.filetype:get() == 'qf' then
      vim.cmd.lclose()
    end
  end
})

-- Plugins Configurations
-- vim-plug
do
  local exists = vim.fn['glob']('~/.config/nvim/autoload/plug.vim') ~= ''
  if not exists then
    vim.fn['system']('curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim')
    vim.api.nvim_created_autocmd({"VimEnter"}, {
      pattern = {"*"},
      command = "PlugInstall --sync | source $MYVIMRC"
    })
  end
end

local Plug = vim.fn['plug#']

vim.fn['plug#begin']('~/.cache/nvim-plugins')

Plug 'junegunn/vim-plug'

-- haskell completion
Plug 'neovimhaskell/haskell-vim'

-- code
Plug 'neomake/neomake'
Plug 'sbdchd/neoformat'
Plug 'junegunn/rainbow_parentheses.vim' -- colorize parentheses
Plug 'Raimondi/delimitMate'             -- autocomplete brackets, parentheses
Plug 'majutsushi/tagbar'                -- taglist browser for many different languages
Plug 'sukima/xmledit'                   -- edit xml
Plug 'tpope/vim-commentary'             -- comments with gc<movement>
Plug 'tpope/vim-surround'               -- surround command

-- utility
Plug 'easymotion/vim-easymotion'
Plug 'mhinz/vim-signify'
Plug 'SirVer/ultisnips'
Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-unimpaired'
Plug 'lervag/vimtex'                    -- latex syntax highlighter
Plug 'airblade/vim-rooter'

Plug 'dhruvasagar/vim-table-mode'

-- fugitive helper
Plug 'shumphrey/fugitive-gitlab.vim'

-- themes
Plug 'joshdick/onedark.vim'
Plug 'itchyny/lightline.vim'

Plug 'neovim/nvim-lspconfig'
Plug('nvim-treesitter/nvim-treesitter', { ['do'] = ':TSUpdate' })

Plug('sourcegraph/sg.nvim', { ['do'] = 'nvim -l build/init.lua' })
Plug 'nvim-lua/plenary.nvim'
vim.fn['plug#end']()

vim.keymap.set('n', '<Leader>pu', '<cmd>PlugUpdate<CR>')
vim.keymap.set('n', '<Leader>pU', '<cmd>PlugUpgrade<CR>')
vim.keymap.set('n', '<Leader>pc', '<cmd>PlugClean<CR>')
vim.keymap.set('n', '<Leader>pi', '<cmd>PlugInstall<CR>')

-- rainbow_parentheses {{{2
do
  local group = vim.api.nvim_create_augroup('EnableRainbowParentheses', {})
  vim.api.nvim_create_autocmd({'FileType'}, {
    group = group,
    pattern = '*',
    command = 'RainbowParentheses'
  })
end

vim.g.rainbow = {
  max_level = 16,
  pairs = { {'(', ')'}, {'[', ']'}, {'{', '}'} },
  blacklist = {233,244},
}


-- vim-easy-align {{{2
vim.keymap.set('v', '<Enter>', '<Plug>(EasyAlign)')
vim.keymap.set('n', 'ga', '<Plug>(EasyAlign)')

-- vim-easymotion {{{2
vim.g.EasyMotion_smartcase  = 1
vim.g.EasyMotion_use_upper  = 1
vim.g.EasyMotion_do_mapping = 0
vim.g.EasyMotion_keys       = 'hjklyuiopnm,qweasdzxcrtfgvb;r'
vim.keymap.set('n', 'f', '<Plug>(easymotion-fl)')
vim.keymap.set('n', 'F', '<Plug>(easymotion-Fl)')
vim.keymap.set('n', 't', '<Plug>(easymotion-tl)')
vim.keymap.set('n', 'T', '<Plug>(easymotion-Tl)')
vim.keymap.set('n', 's', '<Plug>(easymotion-s2)')
vim.keymap.set('n', ';', '<Plug>(easymotion-next)')
vim.keymap.set('n', ':', '<Plug>(easymotion-prev)')

-- vim-signify {{{2
vim.g.signify_vcs_list = {'git'}

-- theme {{{2
vim.cmd([[
colorscheme onedark
hi link EasyMotionTarget EasyMotionTarget2FirstDefault
]])

-- vim-rooter {{{2
vim.g.rooter_manual_only = 1

-- vim-lightline {{{2
vim.cmd([[
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
]])

-- SourceGraph
require('sg').setup{}

-- Language Configurations
local lspconfig = require('lspconfig')

-- C/C++
lspconfig.clangd.setup{}

-- Go
lspconfig.gopls.setup{}

-- Haskell
lspconfig.hls.setup{
  filetypes = { 'haskell', 'lhaskell', 'cabal' },
}

-- LaTeX
lspconfig.texlab.setup{}

-- Lua (Neovim setup)
lspconfig.lua_ls.setup{
  on_init = function(client)
    local path = client.workspace_folders[1].name
    if vim.loop.fs_stat(path..'/.luarc.json') or vim.loop.fs_stat(path..'/.luarc.jsonc') then
      return
    end

    client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
      runtime = {
        -- Tell the language server which version of Lua you're using
        -- (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT'
      },
      -- Make the server aware of Neovim runtime files
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME
          -- Depending on the usage, you might want to add additional paths here.
          -- "${3rd}/luv/library"
          -- "${3rd}/busted/library",
        }
        -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
        -- library = vim.api.nvim_get_runtime_file("", true)
      }
    })
  end,
  settings = {
    Lua = {}
  }
}

-- Kotlin
-- lspconfig.kotlin_language_server.setup{
-- cmd = {"/Users/aufar.gilbran/src/github.com/fwcd/kotlin-language-server/server/build/install/server/bin/kotlin-language-server"}
-- }

-- Python
lspconfig.pyright.setup{}

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

    -- Navigation & Informations
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<Leader>cd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', '<Leader>cD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', '<Leader>ci', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<Leader>ct', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<Leader>cr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<Leader>cs', vim.lsp.buf.signature_help, opts)

    -- Functions
    vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<F3>', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', '<F4>', function()
      vim.lsp.buf.format { async = true }
    end, opts)

    -- See `:help vim.diagnostic.*` for documentation on any of the below functions
    vim.keymap.set('n', '<Leader>dO', vim.diagnostic.open_float)
    vim.keymap.set('n', '<Leader>dp', vim.diagnostic.goto_prev)
    vim.keymap.set('n', '<Leader>dn', vim.diagnostic.goto_next)
  end,
})

-- Treesitter
require('nvim-treesitter.configs').setup {
    highlight = {
        enable = true,
    },
    indent = {
        enable = true,
    },
}
