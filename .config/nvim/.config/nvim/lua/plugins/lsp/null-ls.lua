local status, null_ls = pcall(require, "null-ls")
if (not status) then return end

local augroup_format = vim.api.nvim_create_augroup("Format", { clear = true })

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local completion = null_ls.builtins.completion

null_ls.setup({
    debug = true,
    sources = {
        formatting.eslint_d,
        formatting.prettierd,
        formatting.shfmt,
        formatting.taplo, -- for toml
        formatting.black.with({ extra_args = { "--fast" } }),

        diagnostics.zsh,
        -- diagnostics.eslint_d.with({
        --     diagnostics_format = '[eslint] #{m}\n(#{c})'
        -- }),
    },
    on_attach = function(client, bufnr)
        if client.server_capabilities.documentFormattingProvider then
            vim.api.nvim_clear_autocmds { buffer = 0, group = augroup_format }
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup_format,
                buffer = 0,
                callback = function() vim.lsp.buf.format() end
            })
        end
    end,
})
