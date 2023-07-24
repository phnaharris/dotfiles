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
        formatting.cmake_format.with({
            autosort = true
        }),

        diagnostics.zsh,
        diagnostics.credo.with({
            diagnostics_format = "[credo] #{m}\n(#{c})"
        }),
        diagnostics.cmake_lint.with({
            diagnostics_format = "[cmake_lint] #{m}\n(#{c})"
        }),
        diagnostics.eslint_d.with({
            diagnostics_format = "[eslint] #{m}\n(#{c})"
        }),
    },
    on_attach = function(client, bufnr)
        -- require("plugins.lsp.handlers").formatOnSave(client, bufnr)
    end,
})
