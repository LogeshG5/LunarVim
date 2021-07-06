O.user_which_key = {
  d = {
    name = "+Debug",
    b = {"<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Toggle Breakpoint"},
    B = {"<cmd>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>", "Toggle Conditional Breakpoint"},
    c = {"<cmd>lua require'dap'.continue()<cr>", "Continue"},
    i = {"<cmd>lua require'dap'.step_into()<cr>", "Step Into"},
    o = {"<cmd>lua require'dap'.step_over()<cr>", "Step Over"},
    O = {"<cmd>lua require'dap'.step_out()<cr>", "Step Out"},
    r = {"<cmd>Telescope dap commands theme=get_dropdown<cr>", "Show debug commands"},
    h = {"<cmd>lua require('dap').run_to_cursor()<cr>", "Run to cursor (till Here)"},
    s = {"<cmd>lua require'dap'.continue()<cr>", "Start"},
    S = {"<cmd>lua require('dap').disconnect()<cr>", "Stop"},
    w = {"<cmd>lua require'dap'.repl.toggle()<cr>", "Toggle Repl Window"},
  },
  w = {
    name = "+Save",
    w = {"<cmd>:w!<cr>", "Save"},
    n = {"<cmd>:q!<cr>", "Save None"},
    q = {"<cmd>:wq!<cr>", "Save and quit"},
    s = {"<cmd>:w !sudo -A tee > /dev/null % <cr>", "Sudo Save"},
  },
  s = {
    name = "Search",
    b = {"<cmd>Telescope git_branches<cr>", "Checkout branch"},
    c = {"<cmd>Telescope colorscheme<cr>", "Colorscheme"},
    M = {"<cmd>Telescope man_pages<cr>", "Man Pages"},
    R = {"<cmd>Telescope registers<cr>", "Registers"},
    t = {"<cmd>Telescope live_grep<cr>", "Text"},
    a = {"<cmd>Rg<cr>", "all documents in cwd"},
    f = {"<cmd>Telescope current_buffer_fuzzy_find<cr>", "fuzzy find current document"},
    h = {"<cmd>Rg <cword> %<cr>", "here in this docuement"},
    r = {":%s/<c-r><c-w>//gcI<Left><Left><Left><Left>", "Search and replace"},
  },
}


-- needed to set leader here only then mappings are working
vim.g.mapleader = " "

-- insert empty lines
vim.api.nvim_set_keymap('n', 'oo', ':<C-u>call append(line("."),   repeat([""], v:count1))<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', 'OO', ':<C-u>call append(line(".")-1, repeat([""], v:count1))<CR>', {noremap = true, silent = true})

-- easy save and quit
vim.cmd([[cnoreabbrev w!! w !sudo -A tee > /dev/null %]])
vim.api.nvim_set_keymap('n', '<leader>q', ':q <cr>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>w', ':w! <cr>', {noremap = true, silent = true})

-- Set working directory
vim.api.nvim_set_keymap('n', '<leader>.', ':cd %:p:h<cr>', {noremap = true, silent = true})

local status_ok, wk = pcall(require, "which-key")
if not status_ok then
  return
end

-- Mappings for visual mode
local vopts = {
    mode = "v", -- Visual mode
    prefix = "<leader>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = false -- use `nowait` when creating keymaps
}

wk.register({
    s = {
        name = "Find Word",
        a = {'y:Rg <c-r>"<cr>', "all documents in cwd"},
        h = {'y:Rg <c-r>" %<cr>', "here in current document"},
        r = {'y:%s/<c-r>"//gcI<Left><Left><Left><Left>', "Find and replace"},
    },
}, vopts)
