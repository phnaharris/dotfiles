local status, crates = pcall(require, "crates")
if (not status) then return end

crates.setup({
    null_ls = {
        enabled = true,
        name = "crates.nvim",
    },
})


bind("n", "<leader>ct", crates.toggle)
bind("n", "<leader>cr", crates.reload)

bind("n", "<leader>cv", crates.show_versions_popup)
bind("n", "<leader>cf", crates.show_features_popup)
bind("n", "<leader>cd", crates.show_dependencies_popup)
bind("n", "<leader>cu", crates.update_crate)
bind("v", "<leader>cu", crates.update_crates)
bind("n", "<leader>ca", crates.update_all_crates)
bind("n", "<leader>cU", crates.upgrade_crate)
bind("v", "<leader>cU", crates.upgrade_crates)
bind("n", "<leader>cA", crates.upgrade_all_crates)

bind("n", "<leader>cH", crates.open_homepage)
bind("n", "<leader>cR", crates.open_repository)
bind("n", "<leader>cD", crates.open_documentation)
bind("n", "<leader>cC", crates.open_crates_io)
