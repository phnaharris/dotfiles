local status, null_ls = pcall(require, "null-ls")
if (not status) then return end

local augroup_format = vim.api.nvim_create_augroup("Format", { clear = true })

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local completion = null_ls.builtins.completion
local code_actions = null_ls.builtins.code_actions

null_ls.setup({
    debug = true,
    sources = {
        formatting.prettierd.with({
            disabled_filetypes = { "markdown" }
        }),
        formatting.deno_fmt.with({
            filetypes = { "markdown" },
        }),
        formatting.shfmt,
        formatting.taplo, -- for toml
        formatting.black.with({ extra_args = { "--fast" } }),
        formatting.cmake_format.with({
            autosort = true
        }),
        formatting.latexindent.with({
            filetypes = { "tex", "latex" },
        }),

        diagnostics.zsh,
        diagnostics.proselint.with({
            diagnostics_format = "[proselint] #{m}\n(#{c})"
        }),
        diagnostics.credo.with({
            diagnostics_format = "[credo] #{m}\n(#{c})"
        }),
        diagnostics.cmake_lint.with({
            diagnostics_format = "[cmake_lint] #{m}\n(#{c})"
        }),
        diagnostics.eslint_d.with({
            diagnostics_format = "[eslint] #{m}\n(#{c})"
        }),

        code_actions.proselint,
    },
    on_attach = require("plugins.lsp.handlers").on_attach,
})
