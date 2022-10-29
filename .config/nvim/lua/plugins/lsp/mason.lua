local status, mason = pcall(require, "mason")
if (not status) then return end
local status2, mason_lspconfig = pcall(require, "mason-lspconfig")
if (not status2) then return end

local servers = {
    "bashls",
    "clangd",
    "gopls",
    "jsonls",
    "pyright",
    "rust_analyzer",
    "sumneko_lua",
    "tsserver",
}

mason.setup({
    ui = {
        border = "rounded"
    }
})

mason_lspconfig.setup {
    ensure_installed = servers,
    automatic_installation = true,
}

local status_nvim_lsp, nvim_lsp = pcall(require, 'lspconfig')
if not status_nvim_lsp then return end

for _, server in pairs(servers) do
    local opts = {
        on_attach = require("plugins.lsp.handlers").on_attach,
        capabilities = require("plugins.lsp.handlers").capabilities,
    }

    if (server == "rust_analyzer") then
        local status_rust_tools, rust_tools = pcall(require, "rust-tools")
        if not status_rust_tools then return end
        local status_rust_opts, rust_opts = pcall(require, "plugins.lsp.settings.rust_analyzer")
        if not status_rust_opts then return end

        rust_tools.setup(rust_opts)
        goto continue
    end

    local status_lsopts, language_specific_opts = pcall(require, "plugins.lsp.settings." .. server)
    if not status_lsopts then goto continue end
    opts = vim.tbl_deep_extend("force", language_specific_opts, opts)

    nvim_lsp[server].setup(opts)
    ::continue::
end
