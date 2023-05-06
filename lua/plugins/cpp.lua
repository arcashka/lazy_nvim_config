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
          on_attach = function(_, bufnr)
            vim.keymap.set(
              "n",
              "<leader>bb",
              ":Task start cmake_kits build -j 10<CR>",
              { buffer = bufnr, desc = "CMake build", silent = true }
            )
            vim.keymap.set(
              "n",
              "<leader>br",
              ":Task start cmake_kits run<CR>",
              { buffer = bufnr, desc = "CMake run", silent = true }
            )
            vim.keymap.set(
              "n",
              "<leader>bB",
              ":Task start cmake_kits build_all -j 10<CR>",
              { buffer = bufnr, desc = "CMake build all", silent = true }
            )
            vim.keymap.set(
              "n",
              "<leader>bc",
              ":Task start cmake_kits configure<CR>",
              { buffer = bufnr, desc = "CMake configure", silent = true }
            )
            vim.keymap.set(
              "n",
              "<leader>bt",
              ":Task set_module_param cmake_kits target<CR>",
              { buffer = bufnr, desc = "CMake choose target", silent = true }
            )
            vim.keymap.set(
              "n",
              "<leader>bk",
              ":Task set_module_param cmake_kits build_kit<CR>",
              { buffer = bufnr, desc = "CMake choose build_kit", silent = true }
            )
            vim.keymap.set(
              "n",
              "<leader>bd",
              ":Task set_module_param cmake_kits build_type<CR>",
              { buffer = bufnr, desc = "CMake choose build_type", silent = true }
            )
            vim.keymap.set(
              "n",
              "<leader>bd",
              ":Task set_task_param cmake_kits configure args<CR>",
              { buffer = bufnr, desc = "CMake choose configure args", silent = true }
            )
            vim.keymap.set(
              "n",
              "<A-o>",
              ":ClangdSwitchSourceHeader<CR>",
              { buffer = bufnr, desc = "Switch source/header", silent = true }
            )
          end,
        },
      }
    end,
  },
}
