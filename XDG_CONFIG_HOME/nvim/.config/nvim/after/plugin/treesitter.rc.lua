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
    ensure_installed = { "astro", "c", "cpp", "tsx", "lua", "json", "toml",
        "yaml", "html", "css", "javascript", "typescript", "norg", "help",
        "rust", "go", "python", "markdown", "bash", "dockerfile", "julia",
        "latex", "ruby", "php", "http", "vim", "elixir", "heex", "eex" },
    autotag = {
        enable = true,
    }
}
