local servers = {
	"astro",
	"bashls",
	"clangd",
	"denols",
	"elixirls",
	-- "julials",
	"gopls",
	-- "hls",
	"html",
	"jsonls",
	"pyright",
	"rust_analyzer",
	"solargraph",
	"lua_ls",
	"taplo",
	"tsserver",
	"typst_lsp",
	"yamlls",
}

local lsp_keymaps = function(bufnr)
	local opts = { noremap = true, silent = true }
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<M-a>", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "i", "<M-a>", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gR", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "i", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-k>", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-j>", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gF", "<cmd>lua vim.lsp.buf.format()<CR>", opts)
end

local formatOnSave = function(client, bufnr)
	-- bufnr = 0 ~ current buffer
	-- bufnr = -1 ~ all buffer
	-- bufnr = n ~ specific buffer
	bufnr = bufnr or 0
	if client.server_capabilities.documentFormattingProvider then
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = vim.api.nvim_create_augroup("LspFormating" .. bufnr, { clear = true }),
			buffer = bufnr,
			callback = function()
				vim.lsp.buf.format({
					filter = function(_client)
						return _client.name ~= "tsserver"
							or _client.name ~= "typescript-tools"
							or _client.name ~= "astro"
					end,
				})
			end,
		})
	end
end

local custom_lspconfig = function()
	local float = {
		border = "single",
		style = "minimal",
	}
	local config = {
		virtual_text = {
			format = function(diagnostic)
				local diagnostic_map = {
					[vim.diagnostic.severity.ERROR] = "E",
					[vim.diagnostic.severity.WARN] = "W",
					[vim.diagnostic.severity.INFO] = "I",
					[vim.diagnostic.severity.HINT] = "H",
				}
				return string.format(diagnostic_map[diagnostic.severity] .. ": %s", diagnostic.message)
			end,
		},
		update_in_insert = true,
		-- float = float,
		severity_sort = true,
	}
	vim.diagnostic.config(config)
	-- vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, float)
	-- vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, float)
end

local on_attach = function(client, bufnr)
	formatOnSave(client, bufnr)
	lsp_keymaps(bufnr)
end

local capabilities = function()
	local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
	if status_ok then
		return cmp_nvim_lsp.default_capabilities()
	end

	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities.textDocument.completion.completionItem.snippetSupport = true
	capabilities.textDocument.completion.completionItem.resolveSupport = {
		properties = {
			"documentation",
			"detail",
			"additionalTextEdits",
		},
	}
	capabilities.textDocument.foldingRange = {
		dynamicRegistration = false,
		lineFoldingOnly = true,
	}

	return capabilities
end

return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"folke/neodev.nvim",
		"pmizio/typescript-tools.nvim",
		"b0o/schemastore.nvim",
	},
	on_attach = on_attach,
	config = function()
		require("mason").setup()
		require("mason-lspconfig").setup({
			automatic_installation = true,
		})

		custom_lspconfig()

		for _, server in pairs(servers) do
			local lspconfig = require("lspconfig")
			local opts = {
				on_attach = on_attach,
				capabilities = capabilities(),
			}

			local require_ok, settings = pcall(require, "plugins.lspsettings." .. server)
			if require_ok then
				opts = vim.tbl_deep_extend("force", settings, opts)
			end

			if server == "lua_ls" then
				require("neodev").setup({})
			end

			if server == "tsserver" then
				local status_ok, typescript_tools = pcall(require, "typescript-tools")
				if status_ok then
					typescript_tools.setup(opts)
					goto continue
				end
			end

			lspconfig[server].setup(opts)
			::continue::
		end
	end,
}
