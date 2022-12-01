local status, neorg = pcall(require, "neorg")
if (not status) then return end

neorg.setup({
    load = {
        ["core.defaults"] = {},
        ["core.norg.dirman"] = {
            config = {
                workspaces = {
                    work = "~/Repos/work",
                    home = "~/Repos/home",
                }
            }
        }
    }
})
