-- Contain common setup: lsp_keymap, on_attach function, capabilities --
local status_cmp_nvim_lsp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_cmp_nvim_lsp then return end

local function lsp_keymaps(bufnr)
    local opts = { noremap = true, silent = true }
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gd",
        "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gD",
        "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gi",
        "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<M-a>",
        "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "i", "<M-a>",
        "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "K",
        "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gR",
        "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gr",
        "<cmd>lua vim.lsp.buf.references()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "i", "<C-k>",
        "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-k>",
        "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-j>",
        "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gl",
        "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
end

local float = {
    border = "single",
    style = "minimal",
}

local function config_diagnostic()
    local config = {
        virtual_text     = {
            format = function(diagnostic)
                local diagnostic_map = {
                    [vim.diagnostic.severity.ERROR] = "E",
                    [vim.diagnostic.severity.WARN] = "W",
                    [vim.diagnostic.severity.INFO] = "I",
                    [vim.diagnostic.severity.HINT] = "H",
                }
                return string.format(
                    diagnostic_map[diagnostic.severity] .. ": %s",
                    diagnostic.message)
            end

        },
        update_in_insert = true,
        float            = float,
        severity_sort    = true
    }
    vim.diagnostic.config(config)
end

local function config_handler()
    vim.lsp.handlers["textDocument/hover"] =
        vim.lsp.with(vim.lsp.handlers.hover, float)
    vim.lsp.handlers["textDocument/signatureHelp"] =
        vim.lsp.with(vim.lsp.handlers.signature_help, float)
end

local handlers = {}

handlers.formatOnSave = function(client, bufnr)
    if client.server_capabilities.documentFormattingProvider then
        local augroup_format = vim.api.nvim_create_augroup("Format",
            { clear = true })
        vim.api.nvim_clear_autocmds { buffer = bufnr, group = augroup_format }
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup_format,
            buffer = bufnr,
            callback = function()
                vim.lsp.buf.format {
                    filter = function(_client)
                        return _client.name ~= "tsserver"
                    end
                }
            end
        })
    end
end

handlers.on_attach = function(client, bufnr)
    -- format on save
    handlers.formatOnSave(client, bufnr)

    -- keymap
    lsp_keymaps(bufnr)
end

-- Enable (broadcasting) snippet capability for completion
handlers.capabilities = vim.lsp.protocol.make_client_capabilities()
vim.tbl_deep_extend("force", handlers.capabilities,
    cmp_nvim_lsp.default_capabilities())
handlers.capabilities.textDocument.completion.completionItem.snippetSupport = true

handlers.setup = function()
    config_diagnostic()
    config_handler()
end

return handlers
