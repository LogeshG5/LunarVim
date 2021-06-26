-- vim.g.mapleader = ' '
-- vim.cmd([[cnoreabbrev w!! w !sudo -A tee > /dev/null %]])

-- easy quit
-- vim.api.nvim_set_keymap('n', '<leader>q', ':qa <cr>', {noremap = true, silent = true})
-- vim.api.nvim_set_keymap('n', '<leader>w', ':w! <cr>', {noremap = true, silent = true})
-- vim.api.nvim_set_keymap('n', '<leader>wq', ':wq! <cr>', {noremap = true, silent = true})
-- vim.api.nvim_set_keymap('n', '<leader>wn', ':q! <cr>', {noremap = true, silent = true})
-- vim.api.nvim_set_keymap('n', '<leader>ws', ':w !sudo -A tee > /dev/null % <cr>', {noremap = true, silent = true})

-- explore files
-- vim.api.nvim_set_keymap('n', '<Leader>e', ':lua require("telescope.builtin").find_files({previewer = false})<CR>', {noremap = true, silent = true})

-- tree view
-- vim.api.nvim_set_keymap('n', '<Leader>t', ':NvimTreeToggle<CR>', {noremap = true, silent = true})

-- easy find
-- vim.api.nvim_set_keymap('n', '<leader>f', ':Rg <cr>', {noremap = true, silent = true})
-- vim.api.nvim_set_keymap('n', '<leader>fh', ':Rg <cword> %<cr>', {noremap = true, silent = true})
-- vim.api.nvim_set_keymap('v', '<leader>f', 'y:Rg <c-r>"<cr>', {noremap = true, silent = true})
-- vim.api.nvim_set_keymap('v', '<leader>fh', 'y:Rg <c-r>" %<cr>', {noremap = true, silent = true})

-- find and replace
-- vim.api.nvim_set_keymap('n', '<leader>fr', ':%s/<c-r><c-w>//gcI<Left><Left><Left><Left>', {noremap = true, silent = true})
-- vim.api.nvim_set_keymap('v', '<leader>fr', 'y:%s/<c-r>"//gcI<Left><Left><Left><Left>', {noremap = true, silent = true})

-- paste from clipboard
-- vim.api.nvim_set_keymap('n', '<c-v>', '"+gP<cr>', {noremap = true, silent = true})

-- Set working directory
-- vim.api.nvim_set_keymap('n', '<leader>.', ':cd %:p:h<cr>', {noremap = true, silent = true})

-- insert empty lines
-- vim.api.nvim_set_keymap('n', 'oo', ':<C-u>call append(line("."),   repeat([""], v:count1))<CR>', {noremap = true, silent = true})
-- vim.api.nvim_set_keymap('n', 'OO', ':<C-u>call append(line(".")-1, repeat([""], v:count1))<CR>', {noremap = true, silent = true})

-- better indenting - not working
-- vim.api.nvim_set_keymap('v', '<TAB>', '<gv', {noremap = true, silent = true})
-- vim.api.nvim_set_keymap('v', '<S-TAB>', '>gv', {noremap = true, silent = true})
