return {
	"jay-babu/mason-null-ls.nvim",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"williamboman/mason.nvim",
		"nvimtools/none-ls.nvim",
		"nvim-lua/plenary.nvim",
	},
	config = function()
		local status_ok, null_ls = pcall(require, "null-ls")
		if not status_ok then
			return
		end
		local mason_null_ls = require("mason-null-ls")
		local formatting = null_ls.builtins.formatting
		local diagnostics = null_ls.builtins.diagnostics
		local code_actions = null_ls.builtins.code_actions

		null_ls.setup({
			sources = {
				formatting.prettierd.with({ disabled_filetypes = { "markdown" } }),
				formatting.deno_fmt.with({ filetypes = { "markdown" } }),
				formatting.shfmt,
				formatting.taplo, -- for toml
				formatting.black.with({ extra_args = { "--fast" } }),
				formatting.cmake_format.with({ autosort = true }),
				formatting.latexindent.with({ filetypes = { "tex", "latex" } }),
				formatting.stylua,
				formatting.forge_fmt,

				diagnostics.zsh,
				diagnostics.proselint.with({
					diagnostics_format = "[proselint] #{m}\n(#{c})",
				}),
				diagnostics.credo.with({
					diagnostics_format = "[credo] #{m}\n(#{c})",
				}),
				diagnostics.cmake_lint.with({
					diagnostics_format = "[cmake_lint] #{m}\n(#{c})",
				}),
				diagnostics.eslint_d.with({
					condition = function(utils)
						return utils.root_has_file_matches(".eslintrc.*")
					end,
					diagnostics_format = "[eslint] #{m}\n(#{c})",
				}),
				diagnostics.solhint.with({
					condition = function(utils)
						return utils.root_has_file({ ".solhint.json" })
					end,
					diagnostics_format = "[solhint] #{m}\n(#{c})",
				}),

				code_actions.proselint,
			},
			on_attach = require("plugins.nvim-lspconfig").on_attach,
		})

		mason_null_ls.setup({
			ensure_installed = {},
			automatic_installation = true,
		})
	end,
}
