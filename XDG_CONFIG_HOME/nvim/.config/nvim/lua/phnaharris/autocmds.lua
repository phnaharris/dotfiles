vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = {
        -- "typescript",
        "javascript",
        "javascriptreact",
        "astro",
    },
    callback = function()
        vim.opt_local.shiftwidth = 2
        vim.opt_local.tabstop = 2
    end,
})

-- vim.api.nvim_create_autocmd({ "FileType" }, {
--     pattern = {
--         "python"
--     },
--     callback = function()
--         vim.opt_local.foldmethod = "indent"
--     end,
-- })

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
    pattern = {
        "tsconfig.json"
    },
    command = "set filetype=jsonc",
})

-- vim.api.nvim_create_autocmd({ "BufNewFile" }, {
--     pattern = {
--         "mix.exs"
--     },
--     command = "!mix deps.get",
-- })

-- vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
--     pattern = {
--         ".env"
--     },
--     callback = function()
--         vim.diagnostic.disable() -- cause lost highlighting
--     end,
-- })

vim.api.nvim_create_autocmd({ "TextYankPost" }, {
    pattern = "*",
    callback = function()
        vim.highlight.on_yank({
            higroup = "Search",
            timeout = 40,
        })
    end,
})

-- vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
--     pattern = {
--         "*"
--     },
--     command = "Copilot disable",
-- })

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead", "BufEnter" }, {
    pattern = {
        "*"
    },
    callback = function()
        if not vim.o.modifiable then
            bind("n", "q", ":close<CR>")
        else
            bind("n", "q", "q")
        end
    end
})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead", "BufEnter" }, {
    pattern = {
        "*.conf"
    },
    command = "set filetype=sh"
})

-- auto hover, not really helpful, sometime so annoying
-- vim.api.nvim_create_autocmd({ "CursorHold" }, {
--     pattern = {
--         "*"
--     },
--     command = [[ lua vim.diagnostic.open_float() ]]
-- })

-- vim.api.nvim_create_autocmd({ "ColorScheme" }, {
--     pattern = {
--         "*"
--     },
--     command = [[
--         highlight Normal ctermbg=NONE guibg=NONE
--         highlight link FidgetTitle Normal
--         highlight link FidgetTask Normal
--     ]]
-- })
