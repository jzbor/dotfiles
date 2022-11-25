-- PLUGINS

-- Install packer. You don't have to necessarily understand this code. Just know that it will grab packer from the Internet and install it for you.
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

vim.api.nvim_exec(
  [[
  augroup Packer
    autocmd!
    autocmd BufWritePost init.lua PackerCompile
  augroup end
]],
  false
)

-- Here we can declare the plugins we'll be using.
local use = require('packer').use
require('packer').startup(function()
  use 'wbthomason/packer.nvim' -- Package manager itself.
  use 'tpope/vim-fugitive' -- Git commands for nvim.
  use 'tpope/vim-commentary' -- Use "gc" to comment lines in visual mode. Similarly to cmd+/ in other editors.
  use 'tpope/vim-surround' -- A great tool for adding, removing and changing braces, brackets, quotes and various tags around your text.
  use { 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim' } } -- UI to select things (files, search results, open buffers...)
  --use { 'romgrk/barbar.nvim', requires = {'kyazdani42/nvim-web-devicons'} } -- A bar that will show at the top of you nvim containing your open buffers. Similarly to how other editors show tabs with open files.
  use 'bluz71/vim-moonfly-colors' -- A theme I particularly like.
  use 'fneu/breezy' -- color scheme
  use { 'romainl/Apprentice', branch = "fancylines-and-neovim" } -- color scheme
  use 'itchyny/lightline.vim' -- Fancier status line with some information that will be displayed at the bottom.
  use { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' } } -- Adds git related info in the signs columns (near the line numbers) and popups.
  use 'nvim-treesitter/nvim-treesitter' -- Highlight, edit, and navigate code using a fast incremental parsing library. Treesitter is used by nvim for various things, but among others, for syntax coloring. Make sure that any themes you install support treesitter!
  use 'nvim-treesitter/nvim-treesitter-textobjects' -- Additional textobjects for treesitter.
  use 'neovim/nvim-lspconfig' -- Collection of configurations for built-in LSP client.
  use 'hrsh7th/nvim-cmp' -- Autocompletion plugin.
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'saadparwaiz1/cmp_luasnip'
  use 'L3MON4D3/LuaSnip' -- Snippets plugin.
  use 'vimwiki/vimwiki'
  use 'editorconfig/editorconfig-vim'
end)

-- luasnip setup (you can leave this here or move it to its own configuration file in `lua/plugs/luasnip.lua`.)
luasnip = require 'luasnip'
