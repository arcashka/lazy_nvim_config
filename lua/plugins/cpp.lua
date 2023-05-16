local Path = require("plenary.path")
return {
  {
    "DoDoENT/neovim-additional-tasks",
    opts = {
      default_params = {
        cmake_kits = {
          cmd = "cmake",
          build_type = "release",
          build_kit = "gcc",
          dap_name = "codelldb",
          build_dir = tostring(Path:new("{cwd}", "build")),
          cmake_kits_file = vim.fn.stdpath("config") .. "/resources/" .. "nvim_cmake_kits.json",
          cmake_build_types_file = vim.fn.stdpath("config") .. "/resources/" .. "nvim_cmake_build_types.json",
          clangd_cmdline = {
            "clangd",
            "--background-index",
            "-j=8",
            "--clang-tidy",
            "--completion-style=detailed",
            "--all-scopes-completion",
            "--header-insertion=never",
            "--pch-storage=memory",
            "--log=verbose",
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
          cmd = require("tasks.cmake_kits_utils").currentClangdArgs(),
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
