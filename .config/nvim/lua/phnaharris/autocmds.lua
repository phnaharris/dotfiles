vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = {
        "typescript",
        "javascript",
    },
    callback = function()
        vim.opt_local.shiftwidth = 2
        vim.opt_local.tabstop = 2
    end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = {
        'qf',
        'help',
        'man',
    },
    -- callback = function()
    --     vim.opt_local.shiftwidth = 2
    --     vim.opt_local.tabstop = 2
    -- end,
    command = [[nnoremap <buffer><silent> q :close<CR>]],
})
