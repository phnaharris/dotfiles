local status_configs, configs = pcall(require, "nvim-treesitter.configs")
if not status_configs then return end

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
    context_commentstring = {
        enable = true,
    },
    autotag = {
        enable = true,
    }
}
