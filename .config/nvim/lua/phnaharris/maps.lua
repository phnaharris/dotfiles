local opts = { noremap = true, silent = true }
local function bind(mode, old, new)
    if vim.fn.has("nvim-0.7") then
        vim.keymap.set(mode, old, new, opts)
    end
end

bind('n', '<left>', ':echoe "use h"<CR>')
bind('n', '<right>', ':echoe "use l"<CR>')
bind('n', '<down>', ':echoe "use j"<CR>')
bind('n', '<up>', ':echoe "use k"<CR>')

bind('n', '<C-a>', 'gg<S-v>G') -- select all
bind('n', 'x', '"_x') -- do not yank with x
-- bind('n', '<C-h>', ':nohlsearch<CR>') -- Turn off highlighting search -- Use CTRL_l instead

-- increment/decrement
bind('n', '+', '<C-a>')
bind('n', '-', '<C-x>')

-- tab
bind('n', 'te', ':tabedit %:p:h<CR>')
bind('n', 'tc', ':tabclose<CR>')
bind('n', 'to', ':tabonly<CR>') -- only current tab
-- split
bind('n', 'ss', ':split<CR>')
bind('n', 'sv', ':vsplit<CR>')
bind('n', 'so', ':only<CR>') -- only current window
bind('n', 'sc', ':close<CR>') -- close current window
-- moving around windows in NORMAL, VISUAL, SELECT, OPERATOR-PENDING mode
bind('', 'sh', '<C-w>h')
bind('', 'sj', '<C-w>j')
bind('', 'sk', '<C-w>k')
bind('', 'sl', '<C-w>l')
-- resize split
bind('n', 's<left>', ':vertical resize -2<CR>')
bind('n', 's<right>', ':vertical resize +2<CR>')
bind('n', 's<up>', ':resize +2<CR>')
bind('n', 's<down>', ':resize -2<CR>')

-- nvim-tree keymaps
bind('n', '<leader>sf', ':NvimTreeToggle<CR>')

-- vim.api.nvim_set_keymap("i", "<C-n>", "<Plug>luasnip-next-choice", {})
-- vim.api.nvim_set_keymap("s", "<C-n>", "<Plug>luasnip-next-choice", {})
-- vim.api.nvim_set_keymap("i", "<C-p>", "<Plug>luasnip-prev-choice", {})
-- vim.api.nvim_set_keymap("s", "<C-p>", "<Plug>luasnip-prev-choice", {})
