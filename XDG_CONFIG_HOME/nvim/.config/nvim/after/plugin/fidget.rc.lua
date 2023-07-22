local status, fidget = pcall(require, "fidget")
if (not status) then return end

fidget.setup({
    sources = {
        ["null-ls"] = { ignore = true },
    },
})
