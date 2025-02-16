-- In your plugin files, you can:
-- * add extra plugins
-- * disable/enabled LazyVim plugins
-- * override the configuration of LazyVim plugins
return {
  { "garymjr/nvim-snippets", enabled = false },
  {
    "nvim-flutter/flutter-tools.nvim",
    lazy = false,
    config = true,
  },
  { "sainnhe/everforest" },
  {
    "folke/tokyonight.nvim",
    lazy = true,
    opts = { style = "moon" },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight-night",
    },
  },
  -- { "Mofiqul/vscode.nvim" },
  -- remove annoying notifications
  {
    "folke/noice.nvim",
    opts = {
      messages = {
        enabled = false,
      },
      keys = function()
        return {}
      end,
    },
  },
  {
    "folke/snacks.nvim",
    ---@type snacks.Config
    opts = {
      scroll = {
        enabled = false,
      },
    },
  },
  {
    "folke/flash.nvim",
    opts = {
      modes = {
        search = {
          enabled = false,
        },
      },
    },
  },

  -- add symbols-outline
  {
    "simrat39/symbols-outline.nvim",
    cmd = "SymbolsOutline",
    keys = { { "<leader>cs", "<cmd>SymbolsOutline<cr>", desc = "Symbols Outline" } },
    config = true,
  },

  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = function(_, opts)
      ---@type lspconfig.options
      opts.servers = {
        jsonls = {
          mason = false,
        },
      }
    end,
  },

  -- add more treesitter parsers
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "tsx",
        "typescript",
        "vim",
        "yaml",
        "cpp",
        "rust",
        "wgsl",
      },
    },
  },

  -- add any tools you want to have installed below
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "stylua",
        "shellcheck",
        "shfmt",
        "clangd",
        "cmakelint",
        "python-lsp-server",
        "debugpy",
      },
    },
  },
  {
    "mfussenegger/nvim-dap",
    keys = function()
      return {
        {
          "<F5>",
          function()
            require("dap").continue()
          end,
          desc = "Debug start/continue",
        },
        {
          "<F10>",
          function()
            require("dap").step_over()
          end,
          desc = "Debug step over",
        },
        {
          "<F9>",
          function()
            require("dap").step_into()
          end,
          desc = "Debug step into",
        },
        {
          "<F11>",
          function()
            require("dap").step_out()
          end,
          desc = "Debug step out",
        },
        {
          "<F2>",
          function()
            require("dap").toggle_breakpoint()
          end,
          desc = "Debug toggle breakpoint",
        },
        {
          "<F3>",
          function()
            require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
          end,
          desc = "Debug set breakpoint with condition",
        },
        {
          "<F4>",
          function()
            require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
          end,
          desc = "Debug set breakpoint log point message",
        },
        {
          "<F6>",
          function()
            require("dap").repl.open()
          end,
          desc = "Debug open repl",
        },
        {
          "<F7>",
          function()
            require("dap").run_last()
          end,
          desc = "Debug retun last",
        },
      }
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    keys = function()
      return {
        {
          "<F12>",
          function()
            require("dapui").toggle()
          end,
          desc = "Debug UI",
        },
      }
    end,
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    opts = {
      automatic_setup = true,
      ensure_installed = { "python", "codelldb" },
      handlers = {
        function(config)
          require("mason-nvim-dap").default_setup(config)
        end,
        python = function(config)
          local venv_path = os.getenv("VIRTUAL_ENV") or os.getenv("CONDA_PREFIX")
          local run_with_args = {
            name = "Python: Launch current file with args",
            args = function()
              local argsString = vim.fn.input("Arguments:")
              local args = {}
              for substring in argsString:gmatch("%S+") do
                table.insert(args, substring)
              end
              return args
            end,
            request = "launch",
            type = "python",
            program = "${file}",
            pythonPath = venv_path and (venv_path .. "/bin/python") or nil,
            cwd = venv_path and (venv_path .. "/../") or nil,
          }
          local run = {
            name = "Python: Launch current file",
            request = "launch",
            type = "python",
            program = "${file}",
            pythonPath = venv_path and (venv_path .. "/bin/python") or nil,
            cwd = venv_path and (venv_path .. "/../") or nil,
          }
          -- local run_file = {
          --   name = "Python: TEST",
          --   request = "launch",
          --   type = "python",
          --   program = function()
          --     local programs = { "src/angry_bot.py", "src/dlt_triager.py" }
          --     local program_number = vim.fn.inputlist(programs)
          --     return programs[program_number]
          --   end,
          --   pythonPath = venv_path and (venv_path .. "/bin/python") or nil,
          --   cwd = venv_path and (venv_path .. "/../") or nil,
          -- }
          local run_file = {
            name = "Python: Run file",
            request = "launch",
            type = "python",
            program = function()
              return vim.fn.input("file: ")
            end,
            pythonPath = venv_path and (venv_path .. "/bin/python") or nil,
            cwd = venv_path and (venv_path .. "/../") or nil,
          }
          local hardcode = {
            name = "Python: hardcode",
            request = "launch",
            type = "python",
            args = {
              "--config",
              "SpeechCarFunc",
              "--file",
              "/home/arcashka/Documents/projects/work/test/1.dlt",
              "--output",
            },
            program = "src/dlt_triager.py",
            pythonPath = venv_path and (venv_path .. "/bin/python") or nil,
            cwd = venv_path and (venv_path .. "/../") or nil,
          }
          config.configurations = { hardcode, run, run_with_args, run_file }
          require("mason-nvim-dap").default_setup(config)
        end,
      },
    },
  },
  {
    "chentoast/marks.nvim",
    opts = {
      default_mappings = true,
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      {
        "nvim-telescope/telescope-live-grep-args.nvim",
        version = "^1.0.0",
      },
    },
    config = function(_, opts)
      require("telescope").load_extension("live_grep_args")
      require("telescope").setup(opts)
    end,
    keys = {
      {
        "<leader>fp",
        function()
          require("telescope").extensions.live_grep_args.live_grep_args()
        end,
        desc = "Grep with args",
      },
    },
  },
}
