local status, Comment = pcall(require, "Comment")
if (not status) then return end

Comment.setup({
    ignore = '^$' -- ignore empty line
})
