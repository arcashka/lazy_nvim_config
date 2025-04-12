-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.g.mapleader = ","
vim.g.lazyvim_check_order = false
vim.g.background = "auto"
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.expandtab = true
vim.opt.swapfile = false
vim.opt.mouse = "nv"
vim.opt.foldenable = false
vim.opt.wrap = true

vim.api.nvim_create_autocmd("UIEnter", {
  callback = function(_)
    local uname = vim.loop.os_uname().sysname
    if uname == "Windows_NT" then
      vim.o.guifont = "MesloLGS NF,Hack NF:h14"
    end
    vim.api.nvim_set_keymap("n", "<C-S-n>", ":lua ToggleFullscreen()<CR>", { noremap = true, silent = true })
    vim.g.neovide_theme = "auto"
    vim.g.neovide_detach_on_quit = "always_detach"
    vim.g.neovide_cursor_animation_length = 0.01
    vim.g.neovide_refresh_rate = 144

    function ToggleFullscreen()
      if vim.g.neovide_fullscreen == true then
        vim.g.neovide_fullscreen = false
      else
        vim.g.neovide_fullscreen = true
      end
    end
  end,
})
