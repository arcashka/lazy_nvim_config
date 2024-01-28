local Path = require("plenary.path")
return {
  {
    "DoDoENT/neovim-additional-tasks",
    opts = {
      default_params = {
        cmake_kits = {
          cmd = "cmake", -- CMake executable to use, can be changed using `:Task set_module_param cmake cmd`.
          build_type = "Release", -- default build type, can be changed using `:Task set_module_param cmake build_type`.
          build_kit = "default", -- default build kit, can be changed using `:Task set_module_param cmake build_kit`.
          dap_name = "codelldb", -- DAP configuration name from `require('dap').configurations`. If there is no such configuration, a new one with this name as `type` will be created.
          build_dir = tostring(Path:new("{cwd}", "build")),
          cmake_kits_file = vim.api.nvim_get_runtime_file("cmake_kits.json", false)[1], -- set path to JSON file containing cmake kits
          cmake_build_types_file = vim.api.nvim_get_runtime_file("cmake_build_types.json", false)[1], -- set path to JSON file containing cmake kits
          clangd_cmdline = {
            "clangd",
            "--background-index",
            "--clang-tidy",
            "--header-insertion=never",
            "--completion-style=detailed",
            "--all-scopes-completion",
            "--offset-encoding=utf-8",
            "--pch-storage=memory",
            "--cross-file-rename",
            "--log=verbose",
            "-j=8",
          },
        },
      },
      params_file = "neovim.json",
    },
    dependencies = "Shatur/neovim-tasks",
  },
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = function(_, opts)
      ---@type lspconfig.options
      opts.servers = {
        clangd = {
          cmd = {
            "clangd",
            "--background-index",
            "--clang-tidy",
            "--header-insertion=never",
            "--completion-style=detailed",
            "--all-scopes-completion",
            "--offset-encoding=utf-8",
            "--pch-storage=memory",
            "--cross-file-rename",
            "--log=verbose",
            "-j=8",
            "--query-driver=/usr/bin/c++",
          },
        },
      }
    end,
    keys = {
      {
        "<leader>bs",
        ":Task start cmake_kits build -j 10<CR>",
        desc = "CMake build",
      },
      {
        "<leader>br",
        ":Task start cmake_kits run<CR>",
        desc = "CMake run",
      },
      {
        "<leader>bB",
        ":Task start cmake_kits build_all -j 10<CR>",
        desc = "CMake build all",
      },
      {
        "<leader>bc",
        ":Task start cmake_kits configure<CR>",
        desc = "CMake configure",
      },
      {
        "<leader>bt",
        ":Task set_module_param cmake_kits target<CR>",
        desc = "Change cmake target",
      },
      {
        "<leader>bk",
        ":Task set_module_param cmake_kits build_kit<CR>",
        desc = "Change cmake build_kit",
      },
      {
        "<leader>bd",
        ":Task set_module_param cmake_kits build_type<CR>",
        desc = "Change cmake build_type",
      },
      {
        "<A-o>",
        ":ClangdSwitchSourceHeader<CR>",
        desc = "switch source and header",
      },
    },
  },
}
