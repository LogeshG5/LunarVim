-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile

O.user_plugins = {
  {"jremmen/vim-ripgrep", opt = true},
  {"rcarriga/nvim-dap-ui", opt = true},
  {"theHamsta/nvim-dap-virtual-text", opt = true}
}

O.plugin.dashboard.active = true
O.plugin.colorizer.active = false
O.plugin.debug.active = true
O.plugin.dap_install.active = true
O.plugin.trouble.active = true
O.plugin.symbol_outline.active = true

local function require_plugin(plugin)
  vim.cmd("packadd " .. plugin)
end

require_plugin("nvim-dap")
require_plugin("nvim-dap-ui")
require_plugin("nvim-dap-virtual-text")
require_plugin("vim-ripgrep")

require('lv-nvim-dap')

