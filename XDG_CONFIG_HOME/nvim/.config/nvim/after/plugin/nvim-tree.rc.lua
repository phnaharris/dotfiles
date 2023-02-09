local status, nvimtree = pcall(require, "nvim-tree")
if (not status) then return end

nvimtree.setup({
    -- open_on_setup = false,
    hijack_directories = {
        enable = false, -- disable auto open
    },
    view = {
        mappings = {
            list = {
                { key = "s", action = "" }, -- remove a default mapping for s to open file
            }
        },
    },
    renderer = {
        icons = {
            webdev_colors = true,
            git_placement = "before",
            padding = " ",
            symlink_arrow = " ➛ ",
            show = {
                file = true,
                folder = true,
                folder_arrow = true,
                git = true,
            },
            glyphs = {
                default = "",
                symlink = "",
                git = {
                    unstaged = "",
                    staged = "S",
                    unmerged = "",
                    renamed = "➜",
                    untracked = "U",
                    deleted = "",
                    ignored = "◌",
                },
            },
        },
    },
})
