local servers = {
  "astro",
  "bashls",
  "biome",
  "clangd",
  "denols",
  "elixirls",
  "gopls",
  "html",
  "jsonls",
  "pyright",
  "rust_analyzer",
  "lua_ls",
  "taplo",
  -- "tsserver",
  "typst_lsp",
  "yamlls",
}
local formatters = { "prettierd", "shfmt", "black", "cmakelang", "stylua", "yamlfmt" }
local linters = { "shellcheck", "proselint", "cmakelang", "solhint", "eslint_d" }

return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "folke/neodev.nvim",
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      "pmizio/typescript-tools.nvim",

      { "j-hui/fidget.nvim", opts = {} },

      -- Autoformatting
      "stevearc/conform.nvim",
      -- Linting
      "mfussenegger/nvim-lint",

      -- Schema information
      "b0o/SchemaStore.nvim",
    },
    config = function()
      local capabilities = nil
      if pcall(require, "cmp_nvim_lsp") then
        capabilities = require("cmp_nvim_lsp").default_capabilities()
      end
      require("neodev").setup {}
      require("typescript-tools").setup {
        vim.tbl_deep_extend("force", {}, { capabilities = capabilities }, require "plugins.lspsettings.tsserver"),
      }

      local ensure_installed = {}
      -- vim.list_extend(ensure_installed, servers)
      vim.list_extend(ensure_installed, formatters)
      vim.list_extend(ensure_installed, linters)
      require("mason").setup()
      require("mason-lspconfig").setup()
      require("mason-tool-installer").setup { ensure_installed = ensure_installed }

      local lspconfig = require "lspconfig"
      for _, server in pairs(servers) do
        local require_ok, settings = pcall(require, "plugins.lspsettings." .. server)
        if not require_ok then
          settings = {}
        end
        settings = vim.tbl_deep_extend("force", {}, { capabilities = capabilities }, settings)
        lspconfig[server].setup(settings)
      end

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          assert(vim.lsp.get_client_by_id(args.data.client_id), "must have valid client")

          -- buffer = 0 ~ current buffer
          -- buffer = -1 ~ all buffer
          -- buffer = n ~ specific buffer
          local opts = { buffer = 0 }
          vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
          vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
          vim.keymap.set("n", "<leader>a", vim.lsp.buf.code_action, opts)
          vim.keymap.set("n", "gR", vim.lsp.buf.rename, opts)
          vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
          vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, opts)
          vim.keymap.set("n", "<C-k>", vim.diagnostic.goto_prev, opts)
          vim.keymap.set("n", "<C-j>", vim.diagnostic.goto_next, opts)
          vim.keymap.set("n", "gl", vim.diagnostic.open_float, opts)
        end,
      })

      -- Autoformatting
      require("conform").setup {
        formatters_by_ft = {
          lua = { "stylua" },
          solidity = { "forge_fmt" },
          -- javascript = { { "prettierd", "prettier" } },
          -- javascriptreact = { { "prettierd", "prettier" } },
          -- typescript = { { "prettierd", "prettier" } },
          -- typescriptreact = { { "prettierd", "prettier" } },
          -- json = { { "prettierd", "prettier" } },
          -- jsonc = { { "prettierd", "prettier" } },
          yaml = { "yamlfmt" },
          markdown = { { "deno_fmt" } },
          python = { "black" },
        },
        format_on_save = function(bufnr)
          -- Disable with a global or buffer-local variable
          if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
            return {}
          end
          return {
            -- These options will be passed to conform.format()
            timeout_ms = 500,
            lsp_fallback = true,
            quiet = true,
          }
        end,
      }
      vim.api.nvim_create_user_command("FormatDisable", function(args)
        if args.bang then
          -- FormatDisable! will disable formatting just for this buffer
          vim.b.disable_autoformat = true
        else
          vim.g.disable_autoformat = true
        end
      end, {
        desc = "Disable autoformat-on-save",
        bang = true,
      })
      vim.api.nvim_create_user_command("FormatEnable", function()
        vim.b.disable_autoformat = false
        vim.g.disable_autoformat = false
      end, {
        desc = "Re-enable autoformat-on-save",
      })

      -- Auto linting
      require("lint").linters_by_ft = {
        -- javascript = { "eslint_d" },
        -- typescript = { "eslint_d" },
        markdown = { "proselint" },
        solidity = { "solhint" },
      }
      vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter" }, {
        callback = function()
          require("lint").try_lint()
        end,
      })
    end,
  },
}
