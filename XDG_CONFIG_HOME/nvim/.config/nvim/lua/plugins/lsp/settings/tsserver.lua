local mason_registry = require("mason-registry")
local tsserver_path = mason_registry.get_package("typescript-language-server")
    :get_install_path()

return {
    on_attach = require("plugins.lsp.handlers").on_attach,
    capabilities = require("plugins.lsp.handlers").capabilities,
    settings = {
        filetypes = {
            "typescript",
            "typescriptreact",
            "typescript.tsx",
            "javascript",
            "javascriptreact",
            "javascript.jsx",
        },
        tsserver_path = tsserver_path ..
            "/node_modules/typescript/lib/tsserver.js",
    }
}
