local Path = require("plenary.path")
return {
  {
    "arcashka/neovim-additional-tasks",
    branch = "add_env_args_for_build",
    opts = {
      default_params = {
        cmake_kits = {
          cmd = "cmake",
          build_type = "Release",
          build_kit = "gcc",
          dap_name = "codelldb",
          build_dir = tostring(Path:new("{cwd}", "build")),
          cmake_kits_file = vim.api.nvim_get_runtime_file("nvim_cmake_kits.json", false)[0],
          cmake_build_types_file = vim.api.nvim_get_runtime_file("nvim_cmake_build_types.json", false)[0],
          clangd_cmdline = {
            "clangd",
            "--background-index",
            "--clang-tidy",
            "--header-insertion=never",
            "--completion-style=detailed",
            "--all-scopes-completion",
            "--offset-encoding=utf-8",
            "--pch-storage=memory",
            "--log=verbose",
            "-j=8",
            "--query-driver=/usr/bin/g++",
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
            "-j=8",
            "--query-driver=/usr/bin/g++",
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
