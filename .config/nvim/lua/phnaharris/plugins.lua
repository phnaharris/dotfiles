local status, packer = pcall(require, "packer")
if (not status) then
    print("Packer is not installed")
    return
end

vim.cmd [[packadd packer.nvim]]

-- Auto run :PackerCompile whenever plugins.lua is updated
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

packer.startup(function(use)
    use 'wbthomason/packer.nvim'

    use 'neovim/nvim-lspconfig' -- LSP
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }
    use 'williamboman/mason.nvim'
    use 'williamboman/mason-lspconfig.nvim'
    use 'onsails/lspkind-nvim' -- vscode-like pictograms
    use 'saadparwaiz1/cmp_luasnip' -- nvim-cmp source for luasnip
    use 'L3MON4D3/LuaSnip'

    use 'hrsh7th/cmp-buffer' -- nvim-cmp source for buffer words
    use 'hrsh7th/cmp-nvim-lsp' -- nvim-cmp source for neovim's built-in LSP
    use 'hrsh7th/nvim-cmp' -- Completion

    use 'simrat39/rust-tools.nvim'
    use 'MunifTanjim/prettier.nvim' -- Prettier plugin for Neovim's built-in LSP client
    use 'jose-elias-alvarez/null-ls.nvim' -- Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua

    -- use 'fgheng/winbar.nvim' -- Only support neovim >= 0.8.*
    use 'nvim-lualine/lualine.nvim' -- Statusline
    use 'nvim-lua/plenary.nvim' -- Common utilities
    use 'kyazdani42/nvim-web-devicons' -- File icons

    use 'nvim-tree/nvim-tree.lua'
    use 'nvim-telescope/telescope.nvim'
    use 'nvim-telescope/telescope-file-browser.nvim'

    use 'windwp/nvim-autopairs'
    use 'windwp/nvim-ts-autotag' -- Auto close, rename html tag

    use 'tpope/vim-surround'

    -- Commenting
    use 'numToStr/Comment.nvim'
    -- use 'JoosepAlviste/nvim-ts-context-commentstring'
    -- use { 'iamcco/markdown-preview.nvim', run = 'cd app && yarn install', cmd = 'MarkdownPreview' }
end)
