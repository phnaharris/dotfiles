local augroup = vim.api.nvim_create_augroup -- Create/get autocommand group
local autocmd = vim.api.nvim_create_autocmd -- Create autocommand

-- Help filetype detection
autocmd("BufRead", { pattern = "tsconfig.json", command = "set filetype=jsonc" })
autocmd("BufRead", { pattern = "*.conf", command = "set filetype=sh" })

autocmd({ "TextYankPost" }, {
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({
			higroup = "Search",
			timeout = 40,
		})
	end,
})

-- autocmd({ "ColorScheme" }, {
--     pattern = {
--         "*"
--     },
--     command = [[
--         highlight Normal ctermbg=NONE guibg=NONE
--         highlight link FidgetTitle Normal
--         highlight link FidgetTask Normal
--     ]]
-- })
