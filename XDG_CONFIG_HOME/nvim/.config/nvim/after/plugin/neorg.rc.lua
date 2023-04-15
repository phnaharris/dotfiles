local status, neorg = pcall(require, "neorg")
if (not status) then return end

neorg.setup({
    load = {
        ["core.defaults"] = {},
        ["core.norg.concealer"] = {},
        ["core.norg.dirman"] = {
            config = {
                workspaces = {
                    work = "~/neorg/work",
                    todo = "~/neorg/todo",
                    hcmus = "~/neorg/hcmus",
                    learning = "~/neorg/learning-note"
                }
            }
        }
    }
})
