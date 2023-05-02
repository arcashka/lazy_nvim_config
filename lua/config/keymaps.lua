-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- use ; as :
vim.keymap.set("n", ";", ":")
vim.keymap.set("x", ";", ":")

-- ,w ,q ,Q
vim.keymap.set("n", "<leader>ww", ":update<cr>")
vim.keymap.set("n", "<leader>wq", ":x<cr>", { silent = true })
vim.keymap.set("n", "<leader>Q", ":qa!<cr>", { silent = true })

-- noh
vim.keymap.set("n", "<C-n>", ":noh<cr>")

-- insert blank line
vim.keymap.set("n", "<space>o", "printf('m`%so<esc>``', v:count1)", { expr = true })
vim.keymap.set("n", "<space>O", "printf('m`%sO<esc>``', v:count1)", { expr = true })

-- close quickfix or loclist
vim.keymap.set("n", "<leader>dq", "<cmd>lclose <bar> cclose<cr>", { silent = true })

vim.keymap.set("n", "L", "<cmd>BufferLineCycleNext<cr>", { silent = true })
vim.keymap.set("n", "H", "<cmd>BufferLineCyclePrev<cr>", { silent = true })
vim.keymap.set("n", "<leader>dd", ":<c-U>bprevious <bar> bdelete #<cr>", { silent = true })
vim.keymap.set("n", "<leader>da", "<cmd>BufferLineCloseLeft<cr><cmd>BufferLineCloseRight<cr>", { silent = true })
vim.keymap.set("n", "<leader>dl", "<cmd>BufferLineCloseLeft<cr>", { silent = true })
vim.keymap.set("n", "<leader>dr", "<cmd>BufferLineCloseRight<cr>", { silent = true })
