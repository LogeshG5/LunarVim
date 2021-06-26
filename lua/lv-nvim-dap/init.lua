local dap = require('dap')

-- lldb adapter
-- Issue: Does not open and integrated terminal
dap.adapters.cpp = {
  type = 'executable',
  attach = {
    pidProperty = "pid",
    pidSelect = "ask"
  },
  name = "lldb",
  command = 'lldb-vscode',
  env = {
    LLDB_LAUNCH_FLAG_LAUNCH_IN_TTY = "YES"
  },
}

-- vscode cpptools adapter
-- Issue: pretty print not enabled by default
dap.adapters.cpptools = {
  type = 'executable',
  attach = {
    pidProperty = "pid",
    pidSelect = "ask"
  },
  name = "cppdbg",
  command = vim.fn.stdpath("data") .. "/dapinstall/ccppr_vsc_dbg/extension/debugAdapters/OpenDebugAD7",
  args = {},
  env = {
    LLDB_LAUNCH_FLAG_LAUNCH_IN_TTY = "YES"
  },
}

-- create an adapter for type cppdbg
dap.adapters.cppdbg = dap.adapters.cpptools

dap.defaults.fallback.external_terminal = {
    command = '/usr/bin/alacritty';
    args = {'-e'};
}
dap.defaults.fallback.force_external_terminal = false

dap.defaults.fallback.terminal_win_cmd = '5split new' -- For internal terminal

dap.configurations.cpp = {
  {
    name = "Launch (lldb-vscode)",
    type = 'cpp',
    request = 'launch',
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopAtEntry = true,
    console = "externalTerminal"
  },
  {
    name = "Launch (vscode-cpptools)",
    type = "cpptools",
    request = "launch",
    program = function()
        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end,
    cwd = "${workspaceFolder}",
    stopAtEntry = true,
    console = "integratedTerminal"
  }
}
local debug = {}


-- this will load launch.json
require('dap.ext.vscode').load_launchjs()

-- launch.json comes with type = "cppdbg", so overwrite cpp
-- dap.configurations.cpp = dap.configurations.cppdbg

-- launch.json comes with type = "cppdbg", so add it to cpp
if(dap.configurations.cppdbg) then
    for _,v in pairs(dap.configurations.cppdbg) do table.insert(dap.configurations.cpp, v) end
end

-- local cppdbg_config = dap.configurations.cppdbg
-- if cppdbg_config then
--     cppdbg_config[1].type = "cpptools"
--     table.insert(dap.configurations.cpp, cppdbg_config[1])
-- end

local log = require('dap.log').create_logger('dap.log')
log.error("init.lua", dap.configurations.cpp)

function dap.debug_app(command, ...)
  local config = {
      name = "Launch (vscode-cpptools)",
      type = "cpptools",
      request = "launch",
      program = command,
      args = {...},
      cwd = '${workspaceFolder}',
      stopAtEntry = true,
    }

    dap.run(config)
    -- dap.repl.open()
end

function dap.debug_attach(command)
  local config = {
      type = "cpp",
      name = command,
      request = "attach",
      program = command,
      cwd = '${workspaceFolder}',
      waitFor = true,
      stopAtEntry = true,
        -- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
        --
        --    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
        --
        -- Otherwise you might get the following error:
        --
        --    Error on launch: Failed to attach to the target process
        --
        -- But you should be aware of the implications:
        -- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
      runInTerminal = true,
    }

    dap.run(config)
    -- dap.repl.open()
end

function dap.debug_app_backup(command, ...)
  local config = {
      type = "cpp",
      name = command,
      request = "launch",
      program = command,
      args = {...},
    }

    require('dap.ext.vscode').load_launchjs()
    dap.run(config)
    -- dap.repl.open()
end



vim.g.dap_virtual_text = true

vim.fn.sign_define('DapBreakpoint', {text='', texthl='LspDiagnosticsDefaultError'})
vim.fn.sign_define('DapLogPoint', {text='', texthl='LspDiagnosticsDefaultInformation'})
vim.fn.sign_define('DapStopped', {text=''})

-- Command to debugging
vim.cmd('command! -complete=file -nargs=+ DebugApp lua require("dap").debug_app(<f-args>)')
vim.cmd('command! -complete=file -nargs=+ DebugAttach lua require("dap").debug_attach(<f-args>)')


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
      -- "repl"
    },
    height = 10,
    position = "bottom" -- Can be "bottom" or "top"
  },
  floating = {
    max_height = nil, -- These can be integers or a float between 0 and 1.
    max_width = nil   -- Floats will be treated as percentage of your screen.
  }
})

return debug
