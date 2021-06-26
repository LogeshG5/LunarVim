require("which-key").setup {
    plugins = {
        marks = true, -- shows a list of your marks on ' and `
        registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
        -- the presets plugin, adds help for a bunch of default keybindings in Neovim
        -- No actual key bindings are created
        presets = {
            operators = false, -- adds help for operators like d, y, ...
            motions = false, -- adds help for motions
            text_objects = false, -- help for text objects triggered after entering an operator
            windows = true, -- default bindings on <c-w>
            nav = true, -- misc bindings to work with windows
            z = true, -- bindings for folds, spelling and others prefixed with z
            g = true -- bindings for prefixed with g
        }
    },
    icons = {
        breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
        separator = "➜", -- symbol used between a key and it's label
        group = "+" -- symbol prepended to a group
    },
    window = {
        border = "single", -- none, single, double, shadow
        position = "bottom", -- bottom, top
        margin = {1, 0, 1, 0}, -- extra window margin [top, right, bottom, left]
        padding = {2, 2, 2, 2} -- extra window padding [top, right, bottom, left]
    },
    layout = {
        height = {min = 4, max = 25}, -- min and max height of the columns
        width = {min = 20, max = 50}, -- min and max width of the columns
        spacing = 3 -- spacing between columns
    },
    hidden = {"<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ "}, -- hide mapping boilerplate
    show_help = true, -- show help message on the command line when the popup is visible
    triggers_blacklist = {
        -- list of mode / prefixes that should never be hooked by WhichKey
        -- this is mostly relevant for key maps that start with a native binding
        -- most people should not need to change this
        n = { "o", "O" },
    },
}

local opts = {
    mode = "n", -- NORMAL mode
    prefix = "<leader>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = false -- use `nowait` when creating keymaps
}

-- Set leader
vim.api.nvim_set_keymap('n', '<Space>', '<NOP>', {noremap = true, silent = true})
vim.g.mapleader = ' '

-- no hl
vim.api.nvim_set_keymap('n', '<Leader>h', ':set hlsearch!<CR>', {noremap = true, silent = true})

-- explorer
vim.api.nvim_set_keymap('n', '<Leader>t', ':NvimTreeToggle<CR>', {noremap = true, silent = true})

-- telescope
vim.api.nvim_set_keymap('n', '<Leader>e', ':lua require("telescope.builtin").find_files({previewer = false})<CR>', {noremap = true, silent = true})

-- dashboard
vim.api.nvim_set_keymap('n', '<Leader>;', ':Dashboard<CR>', {noremap = true, silent = true})

-- Comments
vim.api.nvim_set_keymap("n", "<leader>/", ":CommentToggle<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("v", "<leader>/", ":CommentToggle<CR>", {noremap = true, silent = true})

-- close buffer
vim.api.nvim_set_keymap("n", "<leader>c", ":BufferClose!<CR>", {noremap = true, silent = true})

-- open projects
vim.api.nvim_set_keymap('n', '<leader>p', ":Telescope project<CR>", {noremap = true, silent = true})

-- Telescope jumps
vim.api.nvim_set_keymap('n', '<leader>j', ':Telescope jumplist<cr>', {noremap = true, silent = true})

-- TODO create entire treesitter section

vim.api.nvim_set_keymap('n', '<leader>f', ':Rg <cr>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('v', '<leader>f', 'y:Rg <c-r>"<cr>', {noremap = true, silent = true})

local mappings = {
    ["/"] = "Comment",
    ["c"] = "Close Buffer",
    ["t"] = "Explorer",
    ["e"] = "Find files",
    ["h"] = "No Highlight",
    ["p"] = "Projects",
    ["q"] = "Quit all",
    ["."] = "Set cwd",
    f = {
        name = "Find Word",
        a = {"<cmd>Rg<cr>", "all documents in cwd"},
        f = {"<cmd>Telescope current_buffer_fuzzy_find<cr>", "fuzzy find current document"},
        h = {"<cmd>Rg <cword> %<cr>", "here in this docuement"},
        r = {":%s/<c-r><c-w>//gcI<Left><Left><Left><Left>", "Find and replace"},
    },
    D = {
        name = "+Diagnostics",
        t = {"<cmd>TroubleToggle<cr>", "trouble"},
        w = {"<cmd>TroubleToggle lsp_workspace_diagnostics<cr>", "workspace"},
        d = {"<cmd>TroubleToggle lsp_document_diagnostics<cr>", "document"},
        q = {"<cmd>TroubleToggle quickfix<cr>", "quickfix"},
        l = {"<cmd>TroubleToggle loclist<cr>", "loclist"},
        r = {"<cmd>TroubleToggle lsp_references<cr>", "references"},
    },
    d = {
        name = "+Debug",
        b = {"<cmd>DebugToggleBreakpoint<cr>", "Toggle Breakpoint"},
        B = {"<cmd>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>", "Toggle Conditional Breakpoint"},
        c = {"<cmd>DebugContinue<cr>", "Continue"},
        i = {"<cmd>DebugStepInto<cr>", "Step Into"},
        o = {"<cmd>DebugStepOver<cr>", "Step Over"},
        O = {"<cmd>DebugStepOut<cr>", "Step Out"},
        r = {"<cmd>Telescope dap commands theme=get_dropdown<cr>", "Show debug commands"},
        h = {"<cmd>lua require('dap').run_to_cursor()<cr>", "Run to cursor (till Here)"},
        s = {"<cmd>DebugStart<cr>", "Start"},
        S = {"<cmd>lua require('dap').disconnect()<cr>", "Stop"},
        w = {"<cmd>DebugToggleRepl<cr>", "Toggle Repl Window"},
    },
    g = {
        name = "+Git",
        j = {"<cmd>NextHunk<cr>", "Next Hunk"},
        k = {"<cmd>PrevHunk<cr>", "Prev Hunk"},
        p = {"<cmd>PreviewHunk<cr>", "Preview Hunk"},
        r = {"<cmd>ResetHunk<cr>", "Reset Hunk"},
        R = {"<cmd>ResetBuffer<cr>", "Reset Buffer"},
        s = {"<cmd>StageHunk<cr>", "Stage Hunk"},
        u = {"<cmd>UndoStageHunk<cr>", "Undo Stage Hunk"},
        o = {"<cmd>Telescope git_status<cr>", "Open changed file"},
        b = {"<cmd>Telescope git_branches<cr>", "Checkout branch"},
        c = {"<cmd>Telescope git_commits<cr>", "Checkout commit"},
        C = {"<cmd>Telescope git_bcommits<cr>", "Checkout commit(for current file)"},
    },
    l = {
        name = "+LSP",
        a = {"<cmd>Lspsaga code_action<cr>", "Code Action"},
        A = {"<cmd>Lspsaga range_code_action<cr>", "Selected Action"},
        d = {"<cmd>Telescope lsp_document_diagnostics<cr>", "Document Diagnostics"},
        D = {"<cmd>Telescope lsp_workspace_diagnostics<cr>", "Workspace Diagnostics"},
        f = {"<cmd>LspFormatting<cr>", "Format"},
        i = {"<cmd>LspInfo<cr>", "Info"},
        l = {"<cmd>Telescope lsp_references<cr>", "LSP Finder"},
        L = {"<cmd>Lspsaga show_line_diagnostics<cr>", "Line Diagnostics"},
        p = {"<cmd>Lspsaga preview_definition<cr>", "Preview Definition"},
        q = {"<cmd>Telescope quickfix<cr>", "Quickfix"},
        r = {"<cmd>Lspsaga rename<cr>", "Rename"},
        t = {"<cmd>LspTypeDefinition<cr>", "Type Definition"},
        x = {"<cmd>cclose<cr>", "Close Quickfix"},
        s = {"<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols"},
        S = {"<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", "Workspace Symbols"}
    },
    s = {
        name = "+Search",
        b = {"<cmd>Telescope git_branches<cr>", "Checkout branch"},
        c = {"<cmd>Telescope colorscheme<cr>", "Colorscheme"},
        d = {"<cmd>Telescope lsp_document_diagnostics<cr>", "Document Diagnostics"},
        D = {"<cmd>Telescope lsp_workspace_diagnostics<cr>", "Workspace Diagnostics"},
        f = {"<cmd>Telescope find_files<cr>", "Find File"},
        m = {"<cmd>Telescope marks<cr>", "Marks"},
        M = {"<cmd>Telescope man_pages<cr>", "Man Pages"},
        r = {"<cmd>Telescope oldfiles<cr>", "Open Recent File"},
        R = {"<cmd>Telescope registers<cr>", "Registers"},
        t = {"<cmd>Telescope live_grep<cr>", "Text"}
    },
    S = {name = "+Session", s = {"<cmd>SessionSave<cr>", "Save Session"}, l = {"<cmd>SessionLoad<cr>", "Load Session"}},
    w = {
        name = "+Save",
        w = {"<cmd>:w!<cr>", "Save"},
        n = {"<cmd>:q!<cr>", "Save None"},
        q = {"<cmd>:wq!<cr>", "Save and quit"},
        s = {"<cmd>:w !sudo -A tee > /dev/null % <cr>", "Sudo Save"},
    },
    -- extras
    z = {
        name = "+Zen",
        s = {"<cmd>TZBottom<cr>", "toggle status line"},
        t = {"<cmd>TZTop<cr>", "toggle tab bar"},
        z = {"<cmd>TZAtaraxis<cr>", "toggle zen"},
    }
}

local wk = require("which-key")
wk.register(mappings, opts)

-- Mappings for visual mode
local vopts = {
    mode = "v", -- NORMAL mode
    prefix = "<leader>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = false -- use `nowait` when creating keymaps
}

wk.register({
    f = {
        name = "Find Word",
        a = {'y:Rg <c-r>"<cr>', "all documents in cwd"},
        h = {'y:Rg <c-r>" %<cr>', "here in current document"},
        r = {'y:%s/<c-r>"//gcI<Left><Left><Left><Left>', "Find and replace"},
    },
}, vopts)

-- General mappings
-- insert empty lines
vim.api.nvim_set_keymap('n', 'oo', ':<C-u>call append(line("."),   repeat([""], v:count1))<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', 'OO', ':<C-u>call append(line(".")-1, repeat([""], v:count1))<CR>', {noremap = true, silent = true})

-- easy save and quit
vim.cmd([[cnoreabbrev w!! w !sudo -A tee > /dev/null %]])
vim.api.nvim_set_keymap('n', '<leader>q', ':q <cr>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>w', ':w! <cr>', {noremap = true, silent = true})

-- Set working directory
vim.api.nvim_set_keymap('n', '<leader>.', ':cd %:p:h<cr>', {noremap = true, silent = true})



vim.cmd([[nnoremap <expr> k (v:count > 1 ? "m'" . v:count : '') . 'gk']])
vim.cmd([[nnoremap <expr> j (v:count > 1 ? "m'" . v:count : '') . 'gj']])
