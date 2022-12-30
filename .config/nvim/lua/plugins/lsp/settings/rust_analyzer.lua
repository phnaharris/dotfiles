local extension_path = vim.env.HOME ..
    "/.local/share/nvim/mason/packages/codelldb/extension/"
local codelldb_path = extension_path .. "adapter/codelldb"
local liblldb_path = extension_path .. "lldb/lib/liblldb.so"

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
        },
    },
    dap = {
        adapter = require("rust-tools.dap").get_codelldb_adapter(
            codelldb_path, liblldb_path)
    }
}
