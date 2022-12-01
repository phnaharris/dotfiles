local opts = { noremap = true, silent = true }

function bind(mode, old, new)
    if vim.fn.has("nvim-0.7") then
        vim.keymap.set(mode, old, new, opts)
    end
end

bind("n", "<left>", ':echoe "use h"<CR>')
bind("n", "<right>", ':echoe "use l"<CR>')
bind("n", "<down>", ':echoe "use j"<CR>')
bind("n", "<up>", ':echoe "use k"<CR>')

bind("n", "<C-a>", "gg<S-v>G") -- select all
bind("n", "x", '"_x') -- do not yank with x
-- bind('n', '<C-h>', ':nohlsearch<CR>') -- Turn off highlighting search -- Use CTRL_l instead

-- increment/decrement
bind("n", "+", "<C-a>")
bind("n", "-", "<C-x>")

-- tab
bind("n", "te", ":tabedit %:p:h<CR>")
bind("n", "tc", ":tabclose<CR>")
bind("n", "to", ":tabonly<CR>") -- only current tab
-- split
bind("n", "ss", ":split<CR>")
bind("n", "sv", ":vsplit<CR>")
bind("n", "so", ":only<CR>") -- only current window
bind("n", "sc", ":close<CR>") -- close current window
-- moving around windows in NORMAL, VISUAL, SELECT, OPERATOR-PENDING mode
bind("", "sh", "<C-w>h")
bind("", "sj", "<C-w>j")
bind("", "sk", "<C-w>k")
bind("", "sl", "<C-w>l")
-- resize split
bind("n", "<M-h>", ":vertical resize -2<CR>")
bind("n", "<M-l>", ":vertical resize +2<CR>")
bind("n", "<M-k>", ":resize +2<CR>")
bind("n", "<M-j>", ":resize -2<CR>")

-- nvim-tree keymaps
bind("n", "<leader>sf", ":NvimTreeToggle<CR>")

-- src: ThePrimagen
-- faster moving part of text keeping indent
bind("v", "J", ":m '>+1<CR>gv=gv")
bind("v", "K", ":m '<-2<CR>gv=gv")
-- scrolling with centered
bind("n", "<C-d>", "<C-d>zz")
bind("n", "<C-u>", "<C-u>zz")
-- bind({ 'n', 'v' }, '<leader>y', "\"+y")
-- bind({ 'n', 'v' }, '<leader>d', "\"_d")
-- bind({ 'n', 'v' }, '<leader>p', "\"+p")
-- bind({ 'n', 'v' }, '<leader>P', "\"+P")

-- vim.api.nvim_set_keymap("i", "<C-n>", "<Plug>luasnip-next-choice", {})
-- vim.api.nvim_set_keymap("s", "<C-n>", "<Plug>luasnip-next-choice", {})
-- vim.api.nvim_set_keymap("i", "<C-p>", "<Plug>luasnip-prev-choice", {})
-- vim.api.nvim_set_keymap("s", "<C-p>", "<Plug>luasnip-prev-choice", {})

bind("n", "<leader>li", "<cmd>LspInfo<CR>")
bind("n", "<leader>ni", "<cmd>NullLsInfo<CR>")
bind("n", "<leader>m", "<cmd>Mason<CR>")

bind("n", "<leader>xc", ":g/console.lo/d<CR>") -- remove console.log line
