local util = require("lspconfig/util")

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ---@type lspconfig.options.pyright
        pyright = {},
        -- ---@type lspconfig.options.pylsp
        -- pylsp = {},
      },
    },
  },
}
