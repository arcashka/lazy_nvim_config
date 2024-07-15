-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.g.mapleader = ","
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.expandtab = true
vim.opt.swapfile = false
vim.opt.mouse = "nv"
vim.opt.foldenable = false

if vim.g.neovide then
  vim.api.nvim_set_keymap("n", "<C-S-n>", ":lua ToggleFullscreen()<CR>", { noremap = true, silent = true })

  function ToggleFullscreen()
    if vim.g.neovide_fullscreen == true then
      vim.g.neovide_fullscreen = false
    else
      vim.g.neovide_fullscreen = true
    end
  end
end
