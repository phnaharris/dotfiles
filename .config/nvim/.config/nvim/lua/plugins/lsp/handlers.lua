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

    -- vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<cmd>Telescope lsp_declarations<CR>", opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, "n", "gI", "<cmd>Telescope lsp_implementations<CR>", opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<cmd>Telescope lsp_references<CR>", opts)
    -- vim.cmd [[ command! Format execute 'lua vim.lsp.buf.format({ async = true })' ]]
    -- vim.api.nvim_buf_set_keymap(bufnr, "n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<M-f>", "<cmd>Format<cr>", opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<M-s>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>f", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, "n", "[d", '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>', opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, "n", "]d", '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>', opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
end

local function config_diagnostic()
    local config = {
        virtual_text     = true,
        virtual_line     = false,
        update_in_insert = true, -- Update diagnostic while typing (insert mode). Default false (Update when InsertLeave).
        -- float            = {
        --     border = "single",
        --     style = "minimal",
        -- }
    }
    vim.diagnostic.config(config)
end

local function config_handler()
    local float = {
        -- border = "single",
    }
    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover
        , float)
    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers
        .signature_help, float)
end

local handlers = {}

handlers.on_attach = function(client, bufnr)
    if client.name == "tsserver" then
        client.server_capabilities.documentFormattingProvider = false -- 0.8 and later
    end

    -- formatting
    if client.server_capabilities.documentFormattingProvider then
        vim.api.nvim_command [[augroup Format]]
        vim.api.nvim_command [[autocmd! * <buffer>]]
        vim.api.nvim_command [[autocmd BufWritePre <buffer> lua vim.lsp.buf.format()]]
        vim.api.nvim_command [[augroup END]]
    end

    -- keymap
    lsp_keymaps(bufnr)
end

-- Enable (broadcasting) snippet capability for completion
handlers.capabilities = vim.lsp.protocol.make_client_capabilities()
handlers.capabilities.textDocument.completion.completionItem.snippetSupport = true
handlers.capabilities = cmp_nvim_lsp.default_capabilities(handlers.capabilities)

handlers.setup = function()
    config_diagnostic()
    config_handler()
end

return handlers
