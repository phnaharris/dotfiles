vim.g.vimtex_quickfix_open_on_warning = false
vim.g.vimtex_format_enabled = true
vim.g.vimtex_view_method = "zathura"
vim.g.vimtex_view_automatic = false -- dont auto view after compile

-- vim.g.vimtex_compiler_latexmk = {
--     options = {
--         "-verbose",
--         "-file-line-error",
--         "-synctex=1",
--         "-interaction=nonstopmode",
--         "-output-directory=" .. vim.fn.expand("%:p:h") .. "/build",
--     },
-- }

bind("n", "<leader>vc", vim.cmd.VimtexCompile)
bind("n", "<leader>vv", vim.cmd.VimtexView)
bind("n", "<leader>vi", vim.cmd.VimtexInfo)
bind("n", "<leader>VC", function()
    -- single-shot compiling
    vim.cmd("update")
    vim.cmd("VimtexCompileSS")
end)
