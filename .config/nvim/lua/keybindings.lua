-- KEYBINDINGS
-- Plugin specific keybindings are in the plugin's config files.

-- Remap space as leader key. Leader key is a special key that will allow us to make some additional keybindings. I'm using a spacebar, but you can use whatever you'd wish. We'll use it (for example) for searching and changing files (by pressing spacebar, then `s` and then `f`).
vim.api.nvim_set_keymap('', '<Space>', '<Nop>', { noremap = true, silent = true })
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Function keys
vim.api.nvim_set_keymap('n', '<F1>', ':set number!<CR>', {})
vim.api.nvim_set_keymap('n', '<F2>', ':set relativenumber!<CR>', {})
vim.api.nvim_set_keymap('n', '<F3>', ':set cursorline!<CR>', {})
vim.api.nvim_set_keymap('n', '<F4>', ':set list!<CR>', {})
vim.api.nvim_set_keymap('n', '<F5>', ':source ~/.config/nvim/init.lua<CR>', {})
vim.api.nvim_set_keymap('n', '<F6>', ':set wrap!<CR>', {})

-- Split navigation and resizing
vim.api.nvim_set_keymap('n', '<C-h>', ':wincmd h<CR>', {})
vim.api.nvim_set_keymap('n', '<C-j>', ':wincmd j<CR>', {})
vim.api.nvim_set_keymap('n', '<C-k>', ':wincmd k<CR>', {})
vim.api.nvim_set_keymap('n', '<C-l>', ':wincmd l<CR>', {})
vim.api.nvim_set_keymap('n', '<C-Left>', ':vertical resize -5<CR>', {})
vim.api.nvim_set_keymap('n', '<C-Down>', ':resize -5<CR>', {})
vim.api.nvim_set_keymap('n', '<C-Up>', ':resize +5<CR>', {})
vim.api.nvim_set_keymap('n', '<C-Right>', ':vertical resize +5<CR>', {})

-- Tab navigation and moving
vim.api.nvim_set_keymap('n', '<Left>', ':tabprevious<CR>', {})
vim.api.nvim_set_keymap('n', '<Right>', ':tabnext<CR>', {})
vim.api.nvim_set_keymap('n', '<S-Left>', ':tabmove -1<CR>', {})
vim.api.nvim_set_keymap('n', '<S-Right>', ':tabmove +1<CR>', {})

