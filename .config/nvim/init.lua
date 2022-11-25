-- This config is based on the following article:
--      https://tkg.codes/guide-to-modern-neovim-setup-2021/

-- Dependencies
require("plugins")
require("autocmd")
require("commands")
require("keybindings")
require("lsp")

-- Plugin specific configs
require("plugs.cmp")
require("plugs.gitsigns")
require("plugs.telescope")
require("plugs.treesitter")
require("plugs.vimwiki")

-- GENERAL SETTINGS

-- TODO:
-- indentation
-- command mappings

-- Spell checking
vim.o.spell = true -- enable spell-checking
vim.o.spelllang = 'en,de' -- Spell-checking language
vim.g.spellfile_URL = 'http://ftp.vim.org/vim/runtime/spell'
vim.api.nvim_create_autocmd(
  {'ColorScheme'},
  { pattern = {'*'}, command = 'hi SpellBad cterm=underline ctermfg=NONE ctermbg=NONE guifg=NONE ' }
)

-- Folding
vim.o.foldenable = false
vim.o.foldmethod = 'indent'
-- vim.api.nvim_create_autocmd(
--   {'BufReadPost'},
--   { pattern = {'*'}, command = 'normal zR' }
-- )

-- Incremental live completion (note: this is now a default on master).
--vim.o.inccommand = 'nosplit'

-- Scroll n lines before top/bottom
vim.o.scrolloff = 5

-- Set highlight on search. This will remove the highlight after searching for text.
--vim.o.hlsearch = false

-- Configure ruler to the left and cursor highlight line
vim.wo.number = true
vim.wo.relativenumber = false
vim.wo.cursorline = true

-- Enable mouse mode. Sometimes it's easier to scroll using the touchpad for example.
vim.o.mouse = 'a'

-- Enable break indent.
vim.o.breakindent = true

-- Save undo history.
vim.opt.undofile = true

-- Case insensitive searching unless /C or capital in search.
vim.o.ignorecase = true
vim.o.smartcase = true

-- Decrease update time.
vim.o.updatetime = 250
vim.wo.signcolumn = 'yes'

-- Set colorscheme defaults (order is important here).
vim.o.termguicolors = true
vim.g.onedark_terminal_italics = 2
vim.o.background = 'dark'
vim.cmd [[colorscheme apprentice]]

-- Set status bar settings
vim.g.lightline = {
  colorscheme = 'apprentice',
  active = { left = { { 'mode', 'paste' }, { 'gitbranch', 'readonly', 'filename', 'modified' } } },
  component_function = { gitbranch = 'fugitive#head' },
}

-- Highlight on yank (copy). It will do a nice highlight blink of the thing you just copied.
vim.api.nvim_exec(
  [[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]],
  false
)
