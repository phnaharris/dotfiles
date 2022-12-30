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

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
    pattern = {
        "tsconfig.json"
    },
    command = "set filetype=jsonc",
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
    command = "Copilot disable",
})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead", "BufEnter" }, {
    pattern = {
        "*"
    },
    callback = function()
        if not vim.bo.modifiable then
            bind("n", "q", ":close<CR>")
        end
    end
})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead", "BufEnter" }, {
    pattern = {
        "*.conf"
    },
    command = "set filetype=sh"
})

-- Turn off paste mode when leaving insert
vim.api.nvim_create_autocmd("InsertLeave", {
    pattern = "*",
    command = "set nopaste"
})

-- auto hover, not really helpful, sometime so annoying
-- vim.api.nvim_create_autocmd({ "CursorHold" }, {
--     pattern = {
--         "*"
--     },
--     command = [[ lua vim.diagnostic.open_float() ]]
-- })
