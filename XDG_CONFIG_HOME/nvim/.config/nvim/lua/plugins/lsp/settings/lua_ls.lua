return {
    settings = {
        Lua = {
            format = {
                enable = true,
                -- NOTE: the value should be STRING!!
                -- https://github.com/CppCXY/EmmyLuaCodeStyle/blob/master/lua.template.editorconfig
                defaultConfig = {
                    indent_style = "space",
                    indent_size = "2",
                    quote_style = "double",
                    max_line_length = "80",
                    table_separator_style = "comma",
                    keep_one_space_between_table_and_bracket = "true",
                    statement_inline_comment_space = "1",
                    keep_one_space_between_namedef_and_attribute = "true",
                    max_continuous_line_distance = "1",
                    keep_line_after_if_statement = "maxLine:1",
                    keep_line_after_do_statement = "maxLine:1",
                    keep_line_after_while_statement = "maxLine:1",
                    keep_line_after_repeat_statement = "maxLine:1",
                    keep_line_after_for_statement = "maxLine:1",
                    keep_line_after_local_or_assign_statement = "maxLine:1",
                    keep_line_after_function_define_statement = "keepLine:1",
                    keep_line_after_expression_statement = "maxLine:1",
                },
            },
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = "LuaJIT",
                -- Setup your lua path
                -- path = vim.split(package.path, ';'), -- it cause the problem with using gd module required in init.lua
                special = {
                    reload = "require",
                }
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                enable = true, -- Can delete because it's default
                globals = { "vim", "bind" },
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = {
                    [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                    [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
                    -- [vim.fn.stdpath("config") .. "/lua"] = true, -- no need anymore, i don't know why
                    -- [vim.api.nvim_get_runtime_file("", true)] = true,
                },
            },
            completion = {
                enable = true,
                callSnippet = "Replace"
            }
        }
    },
}
