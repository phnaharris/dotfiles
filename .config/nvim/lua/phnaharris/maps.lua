local function bind(mode, old, new)
    if vim.fn.has("nvim-0.7") then
        vim.keymap.set(mode, old, new)
    end
end

bind('n', '<left>', ':echoe "use h"<cr>')
bind('n', '<right>', ':echoe "use l"<cr>')
bind('n', '<down>', ':echoe "use j"<cr>')
bind('n', '<up>', ':echoe "use k"<cr>')

bind('n', '<C-a>', 'gg<S-v>G') -- Select all
bind('n', 'x', '"_x') -- Do not yank with x


-- Increment/Decrement
bind('n', '+', '<C-a>')
bind('n', '-', '<C-x>')

-- tab
bind('n', 'te', ':tabedit %:p:h<CR>')
bind('n', 'tc', ':tabclose<CR>')
bind('n', 'to', ':tabonly<CR>') -- Only current tab
-- split
bind('n', 'ss', ':split<CR>')
bind('n', 'sv', ':vsplit<CR>')
bind('n', 'so', ':only<CR>') -- Only current window
-- moving around windows in NORMAL, VISUAL, SELECT, OPERATOR-PENDING mode
bind('', 'sh', '<C-w>h')
bind('', 'sj', '<C-w>j')
bind('', 'sk', '<C-w>k')
bind('', 'sl', '<C-w>l')
