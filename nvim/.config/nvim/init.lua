-- always set leader firs8t!
vim.g.mapleader = " "

-------------------------------------------------------------------------------
--
-- preferences
--
-------------------------------------------------------------------------------
vim.opt.guicursor = ""
-- never ever folding
vim.opt.foldenable = false
vim.opt.foldmethod = "manual"
vim.opt.foldlevelstart = 99
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.wrap = false
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.numberwidth = 5
vim.opt.smartindent = true -- smart indent reacts to the syntax
vim.opt.tabstop = 4 -- 1 tab = 4 spaces
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4 -- the number of spaces inserted for each indentation
vim.opt.expandtab = true -- convert tabs to spaces
-- vim.opt.list = true
-- vim.opt.listchars = "tab:^ ,nbsp:¬,extends:»,precedes:«,trail:•"
vim.opt.inccommand = "split"
vim.opt.clipboard = "unnamedplus" -- yank to clipboard suck?
vim.opt.cursorline = true
vim.opt.termguicolors = true
vim.opt.pumblend = 5
vim.opt.colorcolumn = "+1"
vim.opt.textwidth = 80
vim.opt.timeoutlen = 500 -- time to wait for key mapping (in ms), default = 1000 ms
vim.opt.updatetime = 50 -- default = 4000
vim.opt.scrolloff = 8
vim.opt.undodir = os.getenv "HOME" .. "/.vim/undodir"
vim.opt.undofile = true
-- Decent wildmenu
vim.opt.wildignore:append { ".git/", ".cache/", "node_modules/", "target/" }
-- in completion, when there is more than one match,
-- list all matches, and only complete to longest common match
vim.opt.wildmode = "list:longest"
vim.opt.path:append { "**" } -- finding files - Search down into subfolders
vim.opt.iskeyword:append { "-" } -- treat dash separated words as a word text object
-- more useful diffs (nvim -d)
--- by ignoring whitespace
vim.opt.diffopt:append "iwhite"
--- and using a smarter algorithm
--- https://vimways.org/2018/the-power-of-diff/
--- https://stackoverflow.com/questions/32365271/whats-the-difference-between-git-diff-patience-and-git-diff-histogram
--- https://luppeng.wordpress.com/2020/10/10/when-to-use-each-of-the-git-diff-algorithms/
vim.opt.diffopt:append "algorithm:histogram"
vim.opt.diffopt:append "indent-heuristic"
-- show a column at 80 characters as a guide for long lines
vim.opt.colorcolumn = "80"

-------------------------------------------------------------------------------
--
-- hotkeys
--
-------------------------------------------------------------------------------
vim.keymap.set("n", "x", '"_x') -- do not yank with x
-- tab
vim.keymap.set("n", "te", ":tabedit %:p:h<CR>")
vim.keymap.set("n", "tc", ":tabclose<CR>")
vim.keymap.set("n", "to", ":tabonly<CR>") -- only current tab
-- split
vim.keymap.set("n", "ss", ":split<CR>")
vim.keymap.set("n", "sv", ":vsplit<CR>")
vim.keymap.set("n", "so", ":only<CR>") -- only current window
vim.keymap.set("n", "sc", ":close<CR>") -- close current window
-- resize split
vim.keymap.set("n", "<M-h>", ":vertical resize -2<CR>")
vim.keymap.set("n", "<M-l>", ":vertical resize +2<CR>")
vim.keymap.set("n", "<M-k>", ":resize +2<CR>")
vim.keymap.set("n", "<M-j>", ":resize -2<CR>")
vim.keymap.set("v", ">", ">gv")
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
-- qf maps
vim.keymap.set("n", "<C-p>", ":cprev<cr>")
vim.keymap.set("n", "<C-n>", ":cnext<cr>")
vim.keymap.set("n", "<C-q>", ":cclose<cr>")

-------------------------------------------------------------------------------
--
-- autocommands
--
-------------------------------------------------------------------------------
-- highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
  pattern = "*",
  callback = function()
    vim.highlight.on_yank { higroup = "Search", timeout = 40 }
  end,
})
-- help filetype detection (add as needed)
--vim.api.nvim_create_autocmd('BufRead', { pattern = '*.ext', command = 'set filetype=someft' })
vim.api.nvim_create_autocmd("BufRead", { pattern = "tsconfig.json", command = "set filetype=jsonc" })

-------------------------------------------------------------------------------
--
-- plugin configuration
--
-------------------------------------------------------------------------------
-- first, grab the manager
-- https://github.com/folke/lazy.nvim
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system { "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)
-- then, setup!
require("lazy").setup {
  -- main color scheme
  {
    "RRethy/base16-nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme "base16-gruvbox-dark-hard"
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local lualine = require "lualine"
      lualine.setup {
        options = { icons_enabled = true, theme = "gruvbox" }, -- dracula / gruvbox / base16
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch" },
          lualine_c = { { "filename", path = 1 } },
          lualine_x = {
            {
              "diagnostics",
              sources = { "nvim_lsp" },
              symbols = {
                error = " ",
                warn = " ",
                info = " ",
                hint = " ",
              },
            },
            "encoding",
            "filetype",
          },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
        extensions = { "fugitive" },
      }
    end,
  },
  -- LSP
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "j-hui/fidget.nvim", config = true },
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
        "yamlls",
      }
      local formatters = { "prettierd", "shfmt", "black", "cmakelang", "stylua", "yamlfmt" }
      local linters = { "shellcheck", "proselint", "cmakelang", "solhint", "eslint_d" }

      local capabilities = nil
      if pcall(require, "cmp_nvim_lsp") then
        capabilities = require("cmp_nvim_lsp").default_capabilities()
      end
      require("neodev").setup {}
      require("typescript-tools").setup {
        vim.tbl_deep_extend("force", {}, { capabilities = capabilities }, require "lspsettings.tsserver"),
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
        local require_ok, settings = pcall(require, "lspsettings." .. server)
        if not require_ok then
          settings = {}
        end
        settings = vim.tbl_deep_extend("force", {}, { capabilities = capabilities }, settings)
        lspconfig[server].setup(settings)
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
  },
  -- Completion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "neovim/nvim-lspconfig",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "saadparwaiz1/cmp_luasnip",
      "L3MON4D3/LuaSnip",
      "rafamadriz/friendly-snippets",
      "onsails/lspkind-nvim",
    },
    event = "InsertEnter",
    config = function()
      local status_cmp, cmp = pcall(require, "cmp")
      if not status_cmp then
        return
      end

      local status_lspkind, lspkind = pcall(require, "lspkind")
      if not status_lspkind then
        return
      end

      local status_luasnip, luasnip = pcall(require, "luasnip")
      if not status_luasnip then
        return
      end

      require("luasnip.loaders.from_vscode").lazy_load()
      luasnip.filetype_extend("all", { "_" })

      local check_backspace = function()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
      end

      cmp.setup {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert {
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-d>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.close(),
          ["<CR>"] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          },
          -- ["<Right>"] = cmp.mapping.confirm { select = true },
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.jumpable(1) then
              luasnip.jump(1)
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            elseif luasnip.expandable() then
              luasnip.expand()
            elseif check_backspace() then
              -- cmp.complete()
              fallback()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        },
        sources = cmp.config.sources {
          { name = "nvim_lsp" },
          { name = "luasnip" }, -- For luasnip users.
          { name = "buffer" },
        },
        ---@diagnostic disable-next-line: missing-fields
        formatting = {
          format = lspkind.cmp_format(),
        },
      }

      vim.g.completeopt = { "menuone", "noinsert", "noselect" }
    end,
  },
  -- Git
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup {
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns
          vim.keymap.set("n", "<leader>hs", gs.stage_hunk)
          vim.keymap.set("n", "<leader>hr", gs.reset_hunk)
          vim.keymap.set("v", "<leader>hs", function()
            gs.stage_hunk { vim.fn.line ".", vim.fn.line "v" }
          end)
          vim.keymap.set("v", "<leader>hr", function()
            gs.reset_hunk { vim.fn.line ".", vim.fn.line "v" }
          end)
          vim.keymap.set("n", "<leader>hS", gs.stage_buffer)
          vim.keymap.set("n", "<leader>hu", gs.undo_stage_hunk)
          vim.keymap.set("n", "<leader>hR", gs.reset_buffer)
          vim.keymap.set("n", "<leader>hp", gs.preview_hunk)
          vim.keymap.set("n", "<leader>hb", function()
            gs.blame_line { full = true }
          end)
          vim.keymap.set("n", "<leader>tb", gs.toggle_current_line_blame)
          vim.keymap.set("n", "<leader>hd", gs.diffthis)
          vim.keymap.set("n", "<leader>hD", function()
            gs.diffthis "~"
          end)
          vim.keymap.set("n", "<leader>td", gs.toggle_deleted)
        end,
        -- current_line_blame = true,
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
          delay = 0,
          ignore_whitespace = false,
        },
      }
    end,
  },
  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = { "windwp/nvim-ts-autotag", config = true },
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require("nvim-ts-autotag").setup {}
      local status, configs = pcall(require, "nvim-treesitter.configs")
      if not status then
        return
      end
      ---@diagnostic disable-next-line: missing-fields
      configs.setup {
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
      }
    end,
  },
  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-file-browser.nvim",
    },
    config = function()
      local telescope = require "telescope"
      local builtin = require "telescope.builtin"
      local cwd = vim.fn.expand "%:p:h"
      local fb_actions = require("telescope").extensions.file_browser.actions

      local file_ignore_patterns = {
        ".git/",
        ".cache/",
        "node_modules/",
        "target/",
      }

      telescope.setup {
        defaults = {
          -- preview = {
          --     filesize_hook = function(filepath, bufnr, opts)
          --         local max_bytes = 10000
          --         local cmd = { "head", "-c", max_bytes, filepath }
          --         require("telescope.previewers.utils").job_maker(cmd,
          --             bufnr, opts)
          --     end
          -- },
          vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            "--hidden",
          },
        },
        extensions = {
          file_browser = {
            theme = "dropdown",
            respect_gitignore = false,
            hidden = true,
            grouped = true,
            path = "%:p:h",
            cwd = cwd,
            initial_mode = "normal",
            -- disables netrw and use telescope-file-browser in its place
            hijack_netrw = true,
            previewer = false,
            layout_config = { height = 40 },
            mappings = {
              -- your custom insert mode mappings
              ["i"] = {
                ["<C-w>"] = function()
                  vim.cmd "normal vbd"
                end,
              },
              ["n"] = {
                -- your custom normal mode mappings
                ["%"] = fb_actions.create,
                ["-"] = fb_actions.goto_parent_dir,
              },
            },
          },
        },
      }

      telescope.load_extension "file_browser"

      vim.keymap.set("n", "<leader>ff", function()
        builtin.find_files {
          file_ignore_patterns = file_ignore_patterns,
          no_ignore = true,
          hidden = true,
        }
      end)
      vim.keymap.set("n", "<leader>r", function()
        builtin.live_grep {
          file_ignore_patterns = file_ignore_patterns,
          hidden = true,
        }
      end)
      vim.keymap.set("n", "<leader>*", function()
        builtin.grep_string {
          file_ignore_patterns = file_ignore_patterns,
          hidden = true,
        }
      end)
      vim.keymap.set("n", "<leader>gf", builtin.git_files)
      vim.keymap.set("n", "<leader>H", builtin.help_tags)
      vim.keymap.set("n", "<leader>qf", builtin.quickfix)
      vim.keymap.set("n", "<leader>km", builtin.keymaps)
      vim.keymap.set("n", "\\\\", builtin.buffers)
      vim.keymap.set("n", "<leader><leader>", builtin.resume)
      vim.keymap.set("n", "<leader>e", builtin.diagnostics)

      vim.keymap.set("n", "sf", telescope.extensions.file_browser.file_browser)
    end,
  },
  {
    "numToStr/Comment.nvim",
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
    config = function()
      vim.g.skip_ts_context_commentstring_module = true
      ---@diagnostic disable-next-line: missing-fields
      require("Comment").setup {
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
        ignore = "^$", -- ignore empty line
      }
    end,
  },
  {
    "windwp/nvim-autopairs",
    config = function()
      local autopairs = require "nvim-autopairs"
      autopairs.setup {
        disable_filetype = { "TelescopePrompt", "vim" },
      }
    end,
  },
  {
    "tpope/vim-surround",
    {
      "tpope/vim-fugitive",
      dependencies = {
        "wcascades/vim-fugitive-toggle",
      },
      config = function()
        vim.keymap.set("n", "<M-g>", "<cmd>lua require('vim-fugitive-toggle').toggle()<cr>")
      end,
    },
  },
  {
    "mbbill/undotree",
    keys = { "<leader>u", "<cmd>UndotreeToggle<CR>", desc = "Undotree" },
    config = function()
      vim.keymap.set("n", "<leader>u", "<cmd>UndotreeToggle<CR>")
    end,
  },
  {
    "lervag/vimtex",
    lazy = false, -- we don't want to lazy load VimTeX
    -- tag = "v2.15", -- uncomment to pin to a specific release
    init = function()
      -- VimTeX configuration goes here, e.g.
      vim.g.vimtex_view_method = "zathura"
    end,
  },
}
