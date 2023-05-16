local util = require("lspconfig/util")

local path = util.path

local function get_python_path(workspace)
  -- Use activated virtualenv.
  if vim.env.VIRTUAL_ENV then
    return path.join(vim.env.VIRTUAL_ENV, "bin", "python")
  end

  -- Find and use virtualenv from pipenv in workspace directory.
  local match = vim.fn.glob(path.join(workspace, "Pipfile"))
  if match ~= "" then
    local venv = vim.fn.trim(vim.fn.system("PIPENV_PIPFILE=" .. match .. " pipenv --venv"))
    return path.join(venv, "bin", "python")
  end

  return vim.fn.exepath("python3") or vim.fn.exepath("python") or "python"
end

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ---@type lspconfig.options.pyright
        pyright = {
          ---@type lspconfig.settings.pyright
          settings = {
            python = {
              pythonPath = "",
            },
          },
        },
        ---@type lspconfig.options.pylsp
        pylsp = {},
      },
      setup = {
        pyright = function(_, opts)
          require("lazyvim.util").on_attach(function(client, _)
            if client.name == "pyright" then
              local pythonPath = get_python_path(client.config.root_dir)
              opts.settings.python.pythonPath = pythonPath
            end
          end)
          require("lspconfig").pyright.setup({ server = opts })
          return true
        end,
      },
    },
  },
}
