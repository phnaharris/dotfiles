local status, ts = pcall(require, 'nvim-treesitter.configs')
if not status then return end

ts.setup {
    highlight = {
        enable = true,
        disable = {},
    },
    indent = {
        enable = true,
        disable = {},
    },
    ensure_installed = { 'c', 'cpp', 'tsx', 'lua', 'json', 'html', 'css', 'javascript', 'typescript', 'rust' },
    autotag = {
        enable = true,
    }
}
