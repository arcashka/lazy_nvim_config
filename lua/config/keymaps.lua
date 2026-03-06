-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- use ; as :
vim.keymap.set("n", ";", ":")
vim.keymap.set("x", ";", ":")

-- ,w ,q ,Q
vim.keymap.set("n", "<leader>ww", ":update<cr>", { silent = true })
vim.keymap.set("n", "<leader>wq", ":x<cr>", { silent = true })
vim.keymap.set("n", "<leader>Q", ":qa!<cr>", { silent = true })

-- noh
vim.keymap.set("n", "<C-n>", ":noh<cr>", { silent = true })

-- insert blank line
vim.keymap.set("n", "<space>o", "printf('m`%so<esc>``', v:count1)", { expr = true, silent = true })
vim.keymap.set("n", "<space>O", "printf('m`%sO<esc>``', v:count1)", { expr = true, silent = true })

-- close quickfix or loclist
vim.keymap.set("n", "<leader>dq", "<cmd>lclose <bar> cclose<cr>", { silent = true })

vim.keymap.set("n", "L", "<cmd>BufferLineCycleNext<cr>", { silent = true })
vim.keymap.set("n", "H", "<cmd>BufferLineCyclePrev<cr>", { silent = true })
vim.keymap.set("n", "<leader>dd", ":<c-U>bprevious <bar> bdelete #<cr>", { silent = true })
vim.keymap.set("n", "<leader>da", "<cmd>BufferLineCloseLeft<cr><cmd>BufferLineCloseRight<cr>", { silent = true })
vim.keymap.set("n", "<leader>dl", "<cmd>BufferLineCloseLeft<cr>", { silent = true })
vim.keymap.set("n", "<leader>dr", "<cmd>BufferLineCloseRight<cr>", { silent = true })

-- Remove default Lazy keymap
vim.keymap.del("n", "<leader>l")

-- Flutter tools
vim.keymap.set("n", "<leader>lr", "<cmd>FlutterRun<cr>", { desc = "Flutter Run" })
vim.keymap.set("n", "<leader>lR", "<cmd>FlutterRestart<cr>", { desc = "Flutter Restart" })
vim.keymap.set("n", "<leader>lq", "<cmd>FlutterQuit<cr>", { desc = "Flutter Quit" })
vim.keymap.set("n", "<leader>ld", "<cmd>FlutterDevices<cr>", { desc = "Flutter Devices" })
vim.keymap.set("n", "<leader>ll", "<cmd>FlutterLogToggle<cr>", { desc = "Flutter Log Toggle" })
vim.keymap.set("n", "<leader>lc", "<cmd>FlutterLogClear<cr>", { desc = "Flutter Log Clear" })

-- Remap Lazy to <leader>L
vim.keymap.set("n", "<leader>L", "<cmd>Lazy<cr>", { desc = "Lazy" })
