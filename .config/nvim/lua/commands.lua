-- COMMANDS

-- Configuration
vim.api.nvim_create_user_command('Config', [[:lua require('telescope.builtin').find_files({previewer = false, cwd = '~/.config/nvim'})<CR>]], {});

-- Git
vim.api.nvim_create_user_command('GGundo', [[:GitGutterUndoHunk<CR>]], {});
vim.api.nvim_create_user_command('GGstage', [[:GitGutterStageHunk<CR>]], {});
