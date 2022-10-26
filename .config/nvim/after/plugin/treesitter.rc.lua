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
    ensure_installed = { 'c', 'cpp', 'tsx', 'lua', 'json', 'toml', 'yaml', 'html', 'css', 'javascript', 'typescript',
        'rust', 'go', 'python', 'markdown', 'bash', 'dockerfile', 'julia', 'latex', 'ruby', 'php' },
    autotag = {
        enable = true,
    }
}
