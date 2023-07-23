local status_cmp, cmp = pcall(require, "cmp")
if (not status_cmp) then return end

local status_lspkind, lspkind = pcall(require, "lspkind")
if (not status_lspkind) then return end

local status_luasnip, luasnip = pcall(require, "luasnip")
if (not status_luasnip) then return end

require("luasnip.loaders.from_vscode").lazy_load()

luasnip.filetype_extend("all", { "_" })

local check_backspace = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and
        vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):
        match "%s" == nil
end

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.close(),
        ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true
        }),
        -- ["<Right>"] = cmp.mapping.confirm { select = true },
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.jumpable(1) then
                luasnip.jump(1)
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            elseif luasnip.expandable() then
                luasnip.expand()
            elseif check_backspace() then
                -- cmp.complete()
                fallback()
            else
                fallback()
            end
        end, {
            "i",
            "s",
        }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, {
            "i",
            "s",
        }),
    }),
    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" }, -- For luasnip users.
        { name = "buffer" },
        { name = "crates" },
    }),
    formatting = {
        format = lspkind.cmp_format({ with_text = true, maxwidth = 100 }),
        before = function(entry, vim_item) -- look like it cannot help to dedup cmp item
            vim_item.dup = ({
                nvim_lsp = 0,
                luasnip = 1,
                buffer = 1,
            })[entry.source.name] or 0
            return vim_item
        end
    }
})

vim.g.completeopt = { "menuone", "noinsert", "noselect" }
