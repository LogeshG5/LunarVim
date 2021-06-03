local dap = require('dap')

dap.adapters.cpp = {
  type = 'executable',
  attach = {
    pidProperty = "pid",
    pidSelect = "ask"
  },
  command = 'lldb-vscode',
  env = {
    LLDB_LAUNCH_FLAG_LAUNCH_IN_TTY = "YES"
  },
  name = "lldb"
}

vim.g.dap_virtual_text = true

vim.fn.sign_define('DapBreakpoint', {text='', texthl='LspDiagnosticsDefaultError'})
vim.fn.sign_define('DapLogPoint', {text='', texthl='LspDiagnosticsDefaultInformation'})
vim.fn.sign_define('DapStopped', {text=''})

-- vim.api.nvim_set_keymap('n', '<leader>dn', '<Cmd>lua require("dap").step_over()<CR>', { noremap = true })
-- vim.api.nvim_set_keymap('n', '<leader>dsi', '<Cmd>lua require("dap").step_into()<CR>', { noremap = true })
-- vim.api.nvim_set_keymap('n', '<leader>dso', '<Cmd>lua require("dap").step_out()<CR>', { noremap = true })
-- vim.api.nvim_set_keymap('n', '<leader>dd', '<Cmd>lua require("dap").continue()<CR>', { noremap = true })
-- vim.api.nvim_set_keymap('n', '<S-F12>', '<Cmd>lua require("dap").pause()<CR>', { noremap = true })
-- vim.api.nvim_set_keymap('n', '<Leader>db', '<Cmd>lua require("dap").toggle_breakpoint()<CR>', { noremap = true })
-- vim.api.nvim_set_keymap('n', '<Leader>dB', '<Cmd>lua require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>', { noremap = true })
-- vim.api.nvim_set_keymap('n', '<Leader>dlp', '<Cmd>lua require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<CR>', { noremap = true })
-- vim.api.nvim_set_keymap('n', '<A-d>', '<Cmd>lua require("dap").repl.toggle({height = 15})<CR>', { noremap = true })
-- vim.api.nvim_set_keymap('n', '<A-BS>', '<Cmd>lua require("dap").disconnect(); require("dap").repl.close()<CR>', { noremap = true })

-- vim.api.nvim_set_keymap('n', '<Leader>p', '<Cmd>Telescope dap list_breakpoints theme=get_dropdown<CR>', { noremap = true })
-- vim.api.nvim_set_keymap('n', '<Leader>dc', '<Cmd>Telescope dap commands theme=get_dropdown<CR>', { noremap = true })
-- vim.api.nvim_set_keymap('n', '<Leader>dv', '<Cmd>Telescope dap variables theme=get_dropdown<CR>', { noremap = true })
-- vim.api.nvim_set_keymap('n', '<Leader>df', '<Cmd>Telescope dap frames theme=get_dropdown<CR>', { noremap = true })

-- Start debugging
vim.cmd('command! -complete=file -nargs=+ Gdb lua require("dap").gdb(<f-args>)')


-- dapui settings
require("dapui").setup({
  icons = {
    expanded = "⯆",
    collapsed = "⯈"
  },
  mappings = {
    -- Use a table to apply multiple mappings
    expand = {"o", "<2-LeftMouse>"},
    open = "o",
    remove = "d",
    edit = "e",
  },
  sidebar = {
    elements = {
      -- You can change the order of elements in the sidebar
      "scopes",
      "breakpoints",
      "stacks",
      "watches"
    },
    width = 40,
    position = "right" -- Can be "left" or "right"
  },
  tray = {
    elements = {
      "repl"
    },
    height = 10,
    position = "bottom" -- Can be "bottom" or "top"
  },
  floating = {
    max_height = nil, -- These can be integers or a float between 0 and 1.
    max_width = nil   -- Floats will be treated as percentage of your screen.
  }
})
local debug = {}

function dap.gdb(command, ...)
  local config = {
      type = "cpp",
      name = command,
      request = "launch",
      program = command,
      args = {...},
    }

    dap.run(config)
    -- dap.repl.open()
end

return debug
