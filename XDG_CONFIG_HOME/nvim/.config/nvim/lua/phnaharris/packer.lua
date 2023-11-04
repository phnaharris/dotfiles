local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath("data") ..
        "/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ "git", "clone", "--depth", "1",
            "https://github.com/wbthomason/packer.nvim", install_path })
        vim.cmd.packadd("packer.nvim")
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

local status, packer = pcall(require, "packer")
if (not status) then
    print("Packer is not installed")
    return
end

vim.cmd.packadd("packer.nvim")

-- Auto run :PackerCompile whenever packer.lua is updated
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost packer.lua source <afile> | PackerCompile
  augroup end
]])

packer.startup(function(use)
    use { "wbthomason/packer.nvim",
        config = function()
            bind("n", "<leader>ps", "<cmd>PackerSync<CR>")
            bind("n", "<leader>pi", "<cmd>PackerInstall<CR>")
            bind("n", "<leader>pc", "<cmd>PackerClean<CR>")
        end

    }

    use "neovim/nvim-lspconfig" -- LSP
    use {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate"
    }
    use "williamboman/mason.nvim"
    use "williamboman/mason-lspconfig.nvim"
    use "onsails/lspkind-nvim"                  -- vscode-like pictograms
    use { "j-hui/fidget.nvim", tag = "legacy" } -- nvim-lsp progress
    use "saadparwaiz1/cmp_luasnip"              -- nvim-cmp source for luasnip
    use "L3MON4D3/LuaSnip"
    use "rafamadriz/friendly-snippets"
    use "jose-elias-alvarez/null-ls.nvim" -- Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua

    use "hrsh7th/nvim-cmp"                -- Completion
    use "hrsh7th/cmp-buffer"              -- nvim-cmp source for buffer words
    use "hrsh7th/cmp-nvim-lsp"            -- nvim-cmp source for neovim's built-in LSP

    use "norcalli/nvim-colorizer.lua"
    use "Saecki/crates.nvim"
    use "simrat39/rust-tools.nvim"
    use { "MrcJkb/haskell-tools.nvim", tag = "1.x.x" }
    use "pmizio/typescript-tools.nvim"
    use({ "elixir-tools/elixir-tools.nvim", tag = "stable" })
    use({
        "iamcco/markdown-preview.nvim",
        run = function() vim.fn["mkdp#util#install"]() end,
        config = function()
            bind("n", "<leader>M", "<cmd>MarkdownPreview<CR>")
            bind("n", "<leader>Ms", "<cmd>MarkdownPreviewStop<CR>")
        end
    })
    use "folke/neodev.nvim"                   -- full signature help, docs and completion for the nvim lua API.

    use "mfussenegger/nvim-dap"               -- Debug Adapter Protocal
    use "rcarriga/nvim-dap-ui"                -- Better UI for debugging
    use "Weissle/persistent-breakpoints.nvim" -- For storing and loading breakpoints
    use "mfussenegger/nvim-dap-python"        -- Extension for nvim-dap providing default configuration for nvim-dap-python
    use "leoluz/nvim-dap-go"                  -- DAP for Golang
    use "mxsdev/nvim-dap-vscode-js"
    use {
        "microsoft/vscode-js-debug",
        opt = true,
        run =
        "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out"
    }

    use "rest-nvim/rest.nvim"
    use "lewis6991/gitsigns.nvim"
    use "nvim-lualine/lualine.nvim"    -- Statusline
    use "nvim-lua/plenary.nvim"        -- Common utilities
    use "kyazdani42/nvim-web-devicons" -- File icons
    -- use 'fgheng/winbar.nvim' -- Only support neovim >= 0.8.*

    -- File browser
    use "nvim-tree/nvim-tree.lua"
    use "nvim-telescope/telescope.nvim"
    use "nvim-telescope/telescope-file-browser.nvim"

    use "windwp/nvim-autopairs"
    use "windwp/nvim-ts-autotag" -- Auto close, rename html tag
    use "h-hg/fcitx.nvim"        -- Switch and restore fcitx state
    use "tpope/vim-surround"
    use "tpope/vim-fugitive"

    -- Commenting
    use "numToStr/Comment.nvim"
    use "JoosepAlviste/nvim-ts-context-commentstring"
    use "b0o/schemastore.nvim"

    use {
        "lervag/vimtex",
    }

    -- use {
    --     "nvim-neorg/neorg",
    --     run = ":Neorg sync-parsers",
    --     after = "nvim-treesitter", -- You may want to specify Telescope here as well
    -- }

    use "mbbill/undotree"
    use "ThePrimeagen/harpoon"

    -- Themes

    use {
        "Mofiqul/dracula.nvim",
        as = "dracula",
        after = "nvim-treesitter",
        config = function()
            -- vim.cmd.colorscheme("dracula")
        end
    }

    -- dracula/vim is not worked well with Gitsigns toggle_current_line_blame
    -- (something wrong with highlighting)
    -- use {
    --     "dracula/vim",
    --     as = "dracula",
    --     after = "nvim-treesitter",
    --     config = function()
    --         vim.cmd.colorscheme("dracula")
    --     end
    -- }

    use({
        "rose-pine/neovim",
        as = "rose-pine",
        config = function()
            -- vim.cmd("colorscheme rose-pine")
        end
    })

    use {
        "ellisonleao/gruvbox.nvim",
        as = "gruvbox",
        after = "nvim-treesitter",
        config = function()
            require("gruvbox").setup({
                palette_overrides = {
                    dark0 = "#1C1E1F"
                }
            })
            vim.cmd.colorscheme("gruvbox")
        end
    }

    use {
        "RRethy/nvim-base16",
        as = "gruvbox-base16",
        after = "nvim-treesitter",
        config = function()
            -- vim.cmd.colorscheme("base16-tomorrow-night")
            -- vim.cmd.colorscheme("base16-gruvbox-dark-hard")
        end
    }

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
        require("packer").sync()
    end
end)
