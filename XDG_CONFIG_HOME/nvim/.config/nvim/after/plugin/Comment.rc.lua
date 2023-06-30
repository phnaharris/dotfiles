local status, Comment = pcall(require, "Comment")
if (not status) then return end

Comment.setup({
    pre_hook = require("ts_context_commentstring.integrations.comment_nvim")
        .create_pre_hook(),
    ignore = "^$" -- ignore empty line
})
