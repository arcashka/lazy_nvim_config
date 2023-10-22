local extension_path = vim.env.HOME .. "/.vscode/extensions/vadimcn.vscode-lldb-1.10.0/"
local codelldb_path = extension_path .. "adapter/codelldb"
local liblldb_path = extension_path .. "lldb/lib/liblldb"
local this_os = vim.loop.os_uname().sysname

-- The path in windows is different
if this_os:find("Windows") then
  codelldb_path = extension_path .. "adapter\\codelldb.exe"
  liblldb_path = extension_path .. "lldb\\bin\\liblldb.dll"
else
  -- The liblldb extension is .so for linux and .dylib for macOS
  liblldb_path = liblldb_path .. (this_os == "Linux" and ".so" or ".dylib")
end

return {
  {
    "simrat39/rust-tools.nvim",
    opts = function(_, opts)
      opts.server = {
        on_attach = function(_, bufnr)
          local rt = require("rust-tools")
          -- Hover actions
          vim.keymap.set("n", "K", rt.hover_actions.hover_actions, { buffer = bufnr })
          -- Code action groups
          vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
          vim.keymap.set("n", "<Leader>br", rt.runnables.runnables, { buffer = bufnr })
        end,
      }
      opts.dap = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path)
      return opts
    end,
  },
}
