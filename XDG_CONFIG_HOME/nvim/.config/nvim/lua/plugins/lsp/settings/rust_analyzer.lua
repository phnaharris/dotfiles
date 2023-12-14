local extension_path = "/usr/lib/codelldb/"
local codelldb_path = extension_path .. "adapter/codelldb"
local liblldb_path = extension_path .. "lldb/lib/liblldb.so"

return {
    settings = {
        ["rust-analyzer"] = {
            cmd = { "rustup", "run", "stable", "rust-analyzer" },
            checkOnSave = {
                command = "clippy"
            },
            assist = {
                merge_imports = true
            },
            cargo = {
                allFeatures = true,
            },
            completion = {
                postfix = {
                    enable = false,
                },
            },
        },
    },

}
