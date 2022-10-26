return {
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
                -- Setup your lua path
                -- path = vim.split(package.path, ';'), -- it cause the problem with using gd module required in init.lua
                special = {
                    reload = "require",
                }
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                enable = true, -- Can delete because it's default
                globals = { 'vim' },
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true),
                -- library = {
                --     [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                --     [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
                --     [vim.fn.stdpath("config") .. "/lua"] = true, -- no need anymore, i don't know why
                -- },
            },
            completion = {
                enable = true,
                callSnippet = "Replace"
            }
        }
    },
}
