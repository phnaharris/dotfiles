local status, mason = pcall(require, "mason")
if (not status) then return end
local status2, mason_lspconfig = pcall(require, "mason-lspconfig")
if (not status2) then return end

local servers = {
    "astro",
    "bashls",
    "clangd",
    "denols",
    "elixirls",
    -- "julials",
    "gopls",
    "hls",
    "html",
    "jsonls",
    "pyright",
    "rust_analyzer",
    "solang",
    "solargraph",
    "lua_ls",
    "taplo",
    "tsserver",
    "yamlls",
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

local status_nvim_lsp, nvim_lsp = pcall(require, "lspconfig")
if not status_nvim_lsp then return end

for _, server in pairs(servers) do
    local opts = {
        on_attach = require("plugins.lsp.handlers").on_attach,
        capabilities = require("plugins.lsp.handlers").capabilities,
    }

    if (server == "hls") then
        local status_haskell_tools, haskell_tools = pcall(require,
            "haskell-tools")
        if not status_haskell_tools then return end
        local status_haskell_opts, haskell_opts = pcall(require,
            "plugins.lsp.settings.hls")
        if not status_haskell_opts then return end

        haskell_tools.setup(haskell_opts)
        goto continue
    end

    if (server == "tsserver") then
        local status_typescript_tools, typescript_tools = pcall(require,
            "typescript-tools")
        if not status_typescript_tools then return end
        local status_typescript_opts, typescript_opts = pcall(require,
            "plugins.lsp.settings.tsserver")

        if status_typescript_tools then
            typescript_tools.setup(ts_opts)
        else
            nvim_lsp[server].setup(ts_opts)
        end

        goto continue
    end

    if (server == "lua_ls") then
        local status_neodev, neodev = pcall(require, "neodev")
        if status_neodev then neodev.setup() end
    end

    local status_lsopts, language_specific_opts = pcall(require,
        "plugins.lsp.settings." .. server)
    if not status_lsopts then goto continue end
    opts = vim.tbl_deep_extend("force", language_specific_opts, opts)

    nvim_lsp[server].setup(opts)
    ::continue::
end
