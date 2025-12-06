-------------------------------------------------------------------------------
--
-- hotkeys
--
-------------------------------------------------------------------------------
vim.keymap.set("n", "x", '"_x') -- do not yank with x
-- tab
vim.keymap.set("n", "te", ":tabedit %:p:h<CR>")
vim.keymap.set("n", "tc", ":tabclose<CR>")
vim.keymap.set("n", "to", ":tabonly<CR>") -- only current tab
-- split
vim.keymap.set("n", "ss", ":split<CR>")
vim.keymap.set("n", "sv", ":vsplit<CR>")
vim.keymap.set("n", "so", ":only<CR>") -- only current window
vim.keymap.set("n", "sc", ":close<CR>") -- close current window
-- resize split
vim.keymap.set("n", "<M-h>", ":vertical resize -2<CR>")
vim.keymap.set("n", "<M-l>", ":vertical resize +2<CR>")
vim.keymap.set("n", "<M-k>", ":resize +2<CR>")
vim.keymap.set("n", "<M-j>", ":resize -2<CR>")
vim.keymap.set("v", ">", ">gv")
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
-- qf maps
vim.keymap.set("n", "<C-p>", ":cprev<cr>")
vim.keymap.set("n", "<C-n>", ":cnext<cr>")
vim.keymap.set("n", "<C-q>", ":cclose<cr>")
