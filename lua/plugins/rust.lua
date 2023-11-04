return {
  {
    "simrat39/rust-tools.nvim",
    opts = function(_, opts)
      opts.tools = {
        on_initialized = function()
          vim.cmd([[
                augroup RustLSP
                  autocmd CursorHold                      *.rs silent! lua vim.lsp.buf.document_highlight()
                  autocmd CursorMoved,InsertEnter         *.rs silent! lua vim.lsp.buf.clear_references()
                  autocmd BufEnter,InsertLeave *.rs silent! lua vim.lsp.codelens.refresh()
                augroup END
              ]])
        end,
      }
    end,
  },
}
