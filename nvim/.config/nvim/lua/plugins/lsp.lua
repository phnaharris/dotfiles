return {
  "neovim/nvim-lspconfig",
  dependencies = {
    { "j-hui/fidget.nvim", config = true },
    "folke/neodev.nvim",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    -- "pmizio/typescript-tools.nvim",
    "j-hui/fidget.nvim",

    -- Autoformatting
    "stevearc/conform.nvim",
    -- Linting
    "mfussenegger/nvim-lint",

    -- Schema information
    "b0o/SchemaStore.nvim",
  },
  config = function()
    local status, util = pcall(require, "lspconfig/util")
    if not status then
      return
    end

    local servers = {
      astro = true,
      bashls = true,
      biome = true,
      taplo = true,
      yamlls = true,
      html = true,
      clangd = {
        cmd = {
          "clangd",
          "--background-index",
          "--suggest-missing-includes",
          "--clang-tidy",
          "--header-insertion=iwyu",
        },
        init_options = {
          clangdFileStatus = true,
        },
        filetypes = { "c", "cpp", "objc", "objcpp" },
        root_dir = util.root_pattern(
          ".clangd",
          ".clang-tidy",
          ".clang-format",
          "compile_commands.json",
          "compile_flags.txt",
          "configure.ac",
          ".git"
        ),
      },
      denols = { root_dir = util.root_pattern("deno.json", "deno.jsonc") },
      elixirls = {
        setting = {
          cmd = vim.env.HOME .. "/.local/share/nvim/mason/packages/elixir-ls/language_server.sh",
        },
      },
      gopls = {
        settings = {
          gopls = {
            analyses = {
              unusedparams = true,
            },
            staticcheck = true,
          },
        },
      },
      jsonls = {
        init_options = {
          provideFormatter = false,
        },
        settings = {
          json = {
            schemas = require("schemastore").json.schemas(),
            validate = { enable = true },
          },
        },
      },
      pyright = {
        settings = {
          python = {
            analysis = {
              typeCheckingMode = "basic",
              diagnosticMode = "workspace",
              inlayHints = {
                variableTypes = true,
                functionReturnTypes = true,
              },
            },
          },
        },
      },
      rust_analyzer = {
        manual_install = true,
        settings = {
          ["rust-analyzer"] = {
            cargo = {
              allFeatures = true,
            },
            imports = {
              group = {
                enable = true,
              },
            },
            completion = {
              postfix = {
                enable = false,
              },
            },
            checkOnSave = {
              command = "clippy",
            },
          },
        },
      },
      lua_ls = {
        settings = {
          Lua = {
            format = { enable = false },
            runtime = {
              -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
              version = "LuaJIT",
              -- Setup your lua path
              -- path = vim.split(package.path, ';'), -- it cause the problem with using gd module required in init.lua
              special = {
                reload = "require",
              },
            },
            diagnostics = {
              -- Get the language server to recognize the `vim` global
              enable = true, -- Can delete because it's default
              globals = { "vim", "bind" },
            },
            workspace = {
              -- Make the server aware of Neovim runtime files
              library = {
                [vim.fn.expand "$VIMRUNTIME/lua"] = true,
                [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
                -- [vim.fn.stdpath("config") .. "/lua"] = true, -- no need anymore, i don't know why
                -- [vim.api.nvim_get_runtime_file("", true)] = true,
              },
            },
            completion = { enable = true, callSnippet = "Replace" },
          },
        },
      },
      vtsls = {},
    }

    local formatters = { "prettierd", "shfmt", "black", "cmakelang", "stylua", "yamlfmt" }
    local linters = { "shellcheck", "proselint", "cmakelang", "solhint", "eslint_d" }
    local ensure_installed = vim.tbl_filter(function(key)
      local t = servers[key]
      if type(t) == "table" then
        return not t.manual_install
      else
        return t
      end
    end, vim.tbl_keys(servers))
    vim.list_extend(ensure_installed, formatters)
    vim.list_extend(ensure_installed, linters)
    require("mason").setup()
    require("mason-lspconfig").setup()
    require("mason-tool-installer").setup { ensure_installed = ensure_installed }

    local capabilities = nil
    if pcall(require, "cmp_nvim_lsp") then
      capabilities = require("cmp_nvim_lsp").default_capabilities()
    end
    require("neodev").setup {}
    -- require("typescript-tools").setup {
    --   vim.tbl_deep_extend("force", {}, { capabilities = capabilities }, servers.vtsls),
    -- }

    for name, setting in pairs(servers) do
      if setting == true then
        setting = {}
      end
      setting = vim.tbl_deep_extend("force", {}, { capabilities = capabilities }, setting)
      vim.lsp.config(name, setting)
      vim.lsp.enable(name)
    end

    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        assert(client, "must have valid client")
        if client.name == "typescript-tools" then
          client.server_capabilities.documentFormattingProvider = false -- 0.8 and later
        end

        -- None of this semantics tokens business.
        -- https://www.reddit.com/r/neovim/comments/143efmd/is_it_possible_to_disable_treesitter_completely/
        client.server_capabilities.semanticTokensProvider = nil

        -- When https://neovim.io/doc/user/lsp.html#lsp-inlay_hint stabilizes
        -- *and* there's some way to make it only apply to the current line.
        -- if client.server_capabilities.inlayHintProvider then
        --   vim.lsp.inlay_hint(args.buf, true)
        -- end

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
        vim.keymap.set("n", "<C-k>", function()
          vim.diagnostic.jump { count = -1, float = true }
        end, opts)
        vim.keymap.set("n", "<C-j>", function()
          vim.diagnostic.jump { count = 1, float = true }
        end, opts)
        vim.keymap.set("n", "gl", vim.diagnostic.open_float, opts)
      end,
    })

    -- Autoformatting
    require("conform").setup {
      formatters_by_ft = {
        lua = { "stylua" },
        solidity = { "forge_fmt" },
        yaml = { "yamlfmt" },
        markdown = { "deno_fmt" },
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
          lsp_format = "fallback",
          quiet = true,
        }
      end,
    }

    -- Auto linting
    require("lint").linters_by_ft = {
      markdown = { "proselint" },
      solidity = { "solhint" },
    }
    vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter" }, {
      callback = function()
        require("lint").try_lint()
      end,
    })
  end,
}
