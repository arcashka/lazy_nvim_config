return {
  {
    "simrat39/rust-tools.nvim",
    lazy = true,
    opts = function()
      local ok, mason_registry = pcall(require, "mason-registry")
      local adapter ---@type any
      if ok then
        -- rust tools configuration for debugging support
        local codelldb = mason_registry.get_package("codelldb")
        local extension_path = codelldb:get_install_path() .. "/extension/"
        local codelldb_path = extension_path .. "adapter/codelldb"
        local liblldb_path = ""
        if vim.loop.os_uname().sysname:find("Windows") then
          liblldb_path = extension_path .. "lldb\\bin\\liblldb.dll"
        elseif vim.fn.has("mac") == 1 then
          liblldb_path = extension_path .. "lldb/lib/liblldb.dylib"
        else
          liblldb_path = extension_path .. "lldb/lib/liblldb.so"
        end
        adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path)
      end
      return {
        dap = {
          adapter = adapter,
        },
        tools = {
          on_initialized = function()
            vim.cmd([[
                augroup RustLSP
                  autocmd CursorHold                      *.rs silent! lua vim.lsp.buf.document_highlight()
                  autocmd CursorMoved,InsertEnter         *.rs silent! lua vim.lsp.buf.clear_references()
                  autocmd BufEnter,InsertLeave *.rs silent! lua vim.lsp.codelens.refresh()
                augroup END
              ]])
          end,
        },
      }
    end,
    config = function() end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        wgsl_analyzer = {
          handlers = {
            ["wgsl-analyzer/requestConfiguration"] = function()
              return {
                success = true,
                customImports = {
                  bevy_pbr = {
                    clustered_forward = "home/arcashka/Documents/projects/other/bevy/crates/bevy_pbr/src/render/clustered_forward.wgsl",
                    mesh_bindings = "home/arcashka/Documents/projects/other/bevy/crates/bevy_pbr/src/render/mesh_bindings.wgsl",
                    mesh_functions = "home/arcashka/Documents/projects/other/bevy/crates/bevy_pbr/src/render/mesh_functions.wgsl",
                    mesh_types = "home/arcashka/Documents/projects/other/bevy/crates/bevy_pbr/src/render/mesh_types.wgsl",
                    mesh_vertex_output = "home/arcashka/Documents/projects/other/bevy/crates/bevy_pbr/src/render/mesh_vertex_output.wgsl",
                    mesh_view_bindings = "home/arcashka/Documents/projects/other/bevy/crates/bevy_pbr/src/render/mesh_view_bindings.wgsl",
                    mesh_view_types = "home/arcashka/Documents/projects/other/bevy/crates/bevy_pbr/src/render/mesh_view_types.wgsl",
                    pbr_bindings = "home/arcashka/Documents/projects/other/bevy/crates/bevy_pbr/src/render/pbr_bindings.wgsl",
                    pbr_functions = "home/arcashka/Documents/projects/other/bevy/crates/bevy_pbr/src/render/pbr_functions.wgsl",
                    lighting = "home/arcashka/Documents/projects/other/bevy/crates/bevy_pbr/src/render/pbr_lighting.wgsl",
                    pbr_types = "home/arcashka/Documents/projects/other/bevy/crates/bevy_pbr/src/render/pbr_types.wgsl",
                    shadows = "home/arcashka/Documents/projects/other/bevy/crates/bevy_pbr/src/render/shadows.wgsl",
                    skinning = "home/arcashka/Documents/projects/other/bevy/crates/bevy_pbr/src/render/skinning.wgsl",
                    utils = "home/arcashka/Documents/projects/other/bevy/crates/bevy_pbr/src/render/utils.wgsl",
                  },
                  bevy_sprite = {
                    mesh2d_bindings = "home/arcashka/Documents/projects/other/bevy/crates/bevy_sprite/src/mesh2d/mesh2d_bindings.wgsl",
                    mesh2d_functions = "home/arcashka/Documents/projects/other/bevy/crates/bevy_sprite/src/mesh2d/mesh2d_functions.wgsl",
                    mesh2d_types = "home/arcashka/Documents/projects/other/bevy/crates/bevy_sprite/src/mesh2d/mesh2d_types.wgsl",
                    mesh2d_vertex_output = "home/arcashka/Documents/projects/other/bevy/crates/bevy_sprite/src/mesh2d/mesh2d_vertex_output.wgsl",
                    mesh2d_view_bindings = "home/arcashka/Documents/projects/other/bevy/crates/bevy_sprite/src/mesh2d/mesh2d_view_bindings.wgsl",
                    mesh2d_view_types = "home/arcashka/Documents/projects/other/bevy/crates/bevy_sprite/src/mesh2d/mesh2d_view_types.wgsl",
                  },
                },
                shaderDefs = {},
                trace = {
                  extension = false,
                  server = false,
                },
                inlayHints = {
                  enabled = false,
                  typeHints = false,
                  parameterHints = false,
                  structLayoutHints = false,
                  typeVerbosity = "inner",
                },
                diagnostics = {
                  typeErrors = false,
                  nagaParsingErrors = false,
                  nagaValidationErrors = false,
                  nagaVersion = "main",
                },
              }
            end,
          },
          settings = {
            ["wgsl-analyzer"] = {},
          },
        },
        -- Ensure mason installs the server
        rust_analyzer = {
          keys = {
            { "K", "<cmd>RustHoverActions<cr>", desc = "Hover Actions (Rust)" },
            { "<leader>cR", "<cmd>RustCodeAction<cr>", desc = "Code Action (Rust)" },
            { "<leader>dr", "<cmd>RustDebuggables<cr>", desc = "Run Debuggables (Rust)" },
            { "<leader>br", "<cmd>RustRunnables<cr>", desc = "Run Runnables (Rust)" },
          },
          settings = {
            ["rust-analyzer"] = {
              cargo = {
                allFeatures = true,
                loadOutDirsFromCheck = true,
                runBuildScripts = true,
              },
              -- Add clippy lints for Rust.
              checkOnSave = {
                allFeatures = true,
                command = "clippy",
                extraArgs = { "--no-deps" },
              },
              procMacro = {
                enable = true,
                ignored = {
                  ["async-trait"] = { "async_trait" },
                  ["napi-derive"] = { "napi" },
                  ["async-recursion"] = { "async_recursion" },
                },
              },
            },
          },
        },
        taplo = {
          keys = {
            {
              "K",
              function()
                if vim.fn.expand("%:t") == "Cargo.toml" and require("crates").popup_available() then
                  require("crates").show_popup()
                else
                  vim.lsp.buf.hover()
                end
              end,
              desc = "Show Crate Documentation",
            },
          },
        },
      },
      setup = {
        rust_analyzer = function(_, opts)
          local rust_tools_opts = require("lazyvim.util").opts("rust-tools.nvim")
          require("rust-tools").setup(vim.tbl_deep_extend("force", rust_tools_opts or {}, { server = opts }))
          return true
        end,
      },
    },
  },
  {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = {
      "rouge8/neotest-rust",
    },
    opts = {
      adapters = {
        ["neotest-rust"] = {},
      },
    },
  },
  {
    "williamboman/mason.nvim",
    optional = true,
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "codelldb" })
      end
    end,
  },
}
