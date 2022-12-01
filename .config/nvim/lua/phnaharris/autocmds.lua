vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = {
        -- "typescript",
        "javascript",
        "javascriptreact",
    },
    callback = function()
        vim.opt_local.shiftwidth = 2
        vim.opt_local.tabstop = 2
    end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = {
        "qf",
        "help",
        "man",
        "httpResult",
    },
    command = [[nnoremap <buffer><silent> q :close<CR>]],
})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
    pattern = {
        "tsconfig.json"
    },
    command = [[set filetype=jsonc]],
})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
    pattern = {
        ".env"
    },
    callback = function()
        vim.diagnostic.disable()
    end,
})

vim.api.nvim_create_autocmd({ "TextYankPost" }, {
    pattern = "*",
    callback = function()
        vim.highlight.on_yank({
            higroup = "IncSearch",
            timeout = 40,
        })
    end,
})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
    pattern = {
        "*"
    },
    command = [[Copilot disable]],
})
