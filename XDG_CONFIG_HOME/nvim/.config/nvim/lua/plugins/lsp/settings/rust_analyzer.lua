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
