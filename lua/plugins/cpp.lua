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
            "/home/dev/.local/share/nvim/mason/bin/clangd",
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
    keys = {
      {
        "<leader>bb",
        ":Task start cmake_kits build -j 10<CR>",
        mode = "n",
        desc = "Cmake build",
      },
      {
        "<leader>bB",
        ":Task start cmake_kits build_all -j 10<CR>",
        mode = "n",
        desc = "Cmake build all",
      },
      {
        "<leader>bc",
        ":Task start cmake_kits configure<CR>",
        mode = "n",
        desc = "Cmake configure",
      },
      {
        "<leader>bt",
        ":Task set_module_param cmake_kits target<CR>",
        mode = "n",
        desc = "Cmake choose target",
      },
      {
        "<leader>bk",
        ":Task set_module_param cmake_kits build_kit<CR>",
        mode = "n",
        desc = "Cmake choose build kit",
      },
      {
        "<leader>bd",
        ":Task set_module_param cmake_kits build_type<CR>",
        mode = "n",
        desc = "Cmake choose build type",
      },
      {
        "<leader>ba",
        ":Task set_task_param cmake_kits configure args<CR>",
        mode = "n",
        desc = "Cmake add args",
      },
      {
        "<leader>br",
        ":Task start cmake_kits run<CR>",
        mode = "n",
        desc = "Cmake run",
      },
    },
    dependencies = "Shatur/neovim-tasks",
  },
}
