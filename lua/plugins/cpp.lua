local Path = require("plenary.path")
return {
  {
    "DoDoENT/neovim-additional-tasks",
    opts = {
      default_params = { -- Default module parameters with which `neovim.json` will be created.
        cmake_kits = {
          cmd = "cmake", -- CMake executable to use, can be changed using `:Task set_module_param cmake cmd`.
          build_type = "debug", -- default build type, can be changed using `:Task set_module_param cmake build_type`.
          build_kit = "gcc", -- default build kit, can be changed using `:Task set_module_param cmake build_kit`.
          dap_name = "codelldb", -- DAP configuration name from `require('dap').configurations`. If there is no such configuration, a new one with this name as `type` will be created.
          build_dir = tostring(Path:new("{cwd}", "build")), -- Build directory. The expressions `{cwd}`, `{os}` and `{build_type}` will be expanded with the corresponding text values. Could be a function that return the path to the build directory.
          cmake_kits_file = vim.api.nvim_get_runtime_file("nvim_cmake_kits.json", false)[1], -- set path to JSON file containing cmake kits
          cmake_build_types_file = vim.api.nvim_get_runtime_file("nvim_cmake_build_types.json", false)[1], -- set path to JSON file containing cmake kits
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
        "<C-b>b",
        ":Task start cmake_kits build -j 10<CR>",
        mode = "n",
        desc = "Cmake build",
      },
      {
        "<C-b>B",
        ":Task start cmake_kits build_all -j 10<CR>",
        mode = "n",
        desc = "Cmake build all",
      },
      {
        "<C-b>c",
        ":Task start cmake_kits configure<CR>",
        mode = "n",
        desc = "Cmake configure",
      },
      {
        "<C-b>t",
        ":Task set_module_param cmake_kits target<CR>",
        mode = "n",
        desc = "Cmake choose target",
      },
      {
        "<C-b>r",
        ":Task start cmake_kits run<CR>",
        mode = "n",
        desc = "Cmake run",
      },
    },
    dependencies = "Shatur/neovim-tasks",
  },
}
