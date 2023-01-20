local def_opts = { noremap = true, silent = true, }

return {
    hls = {
        -- See nvim-lspconfig's  suggested configuration for keymaps, etc.
        capabilities = require("plugins.lsp.handlers").capabilities,
        on_attach = function(client, bufnr)
            local opts = vim.tbl_extend("keep", def_opts, { buffer = bufnr, })
            -- haskell-language-server relies heavily on codeLenses,
            -- so auto-refresh (see advanced configuration) is enabled by default
            vim.keymap.set("n", "<space>ca", vim.lsp.codelens.run, opts)
            vim.keymap.set("n", "<space>hs",
                require("haskell-tools").hoogle.hoogle_signature, opts)
            require("plugins.lsp.handlers").on_attach(client, bufnr)
        end,
    },
    tools = {
        codeLens = {
            autoRefresh = true
        }
    }
}
