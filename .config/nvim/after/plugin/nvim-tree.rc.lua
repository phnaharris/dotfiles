local status, nvimtree = pcall(require, "nvim-tree")
if (not status) then return end

nvimtree.setup()
