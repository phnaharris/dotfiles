local status_configs, configs = pcall(require, "nvim-treesitter.configs")
if not status_configs then return end
require("ts_context_commentstring").setup({})
vim.g.skip_ts_context_commentstring_module = true
configs.setup {
    auto_install = true,
    highlight = {
        enable = true,
        disable = {},
    },
    indent = {
        enable = true,
        disable = {},
    },
    autotag = {
        enable = true,
    }
}
