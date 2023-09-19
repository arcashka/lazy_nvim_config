local has_npm = vim.fn.system("command -v npm") ~= ""
local servers = has_npm and {
    ---@type lspconfig.options.pyright
    pyright = {},
  } or {
    ---@type lspconfig.options.pylsp
    pylsp = {},
  }
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = servers,
    },
  },
}
