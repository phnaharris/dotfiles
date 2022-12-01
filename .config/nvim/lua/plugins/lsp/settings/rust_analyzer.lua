return {
    server = {
        on_attach = require("plugins.lsp.handlers").on_attach,
        capabilities = require("plugins.lsp.handlers").capabilities,
        settings = {
            ["rust-analyzer"] = {
                -- checkOnSave = {
                --     command = "clippy"
                -- },
                checkOnSave = false
            },
        }
    },
}
