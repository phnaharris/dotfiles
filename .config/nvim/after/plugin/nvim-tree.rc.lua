local status, nvimtree = pcall(require, "nvim-tree")
if (not status) then return end

nvimtree.setup({
    -- open_on_setup = false,
    hijack_directories = {
        enable = false, -- disable auto open
    }
})
