return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope-file-browser.nvim",
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")
		local builtin = require("telescope.builtin")
		local cwd = vim.fn.expand("%:p:h")
		local fb_actions = require("telescope").extensions.file_browser.actions

		local file_ignore_patterns = {
			".git/",
			".cache/",
			"node_modules/",
			"target/",
		}

		telescope.setup({
			defaults = {
				-- preview = {
				--     filesize_hook = function(filepath, bufnr, opts)
				--         local max_bytes = 10000
				--         local cmd = { "head", "-c", max_bytes, filepath }
				--         require("telescope.previewers.utils").job_maker(cmd,
				--             bufnr, opts)
				--     end
				-- },
				vimgrep_arguments = {
					"rg",
					"--color=never",
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
					"--smart-case",
					"--hidden",
				},
			},
			extensions = {
				file_browser = {
					theme = "dropdown",
					respect_gitignore = false,
					hidden = true,
					grouped = true,
					path = "%:p:h",
					cwd = cwd,
					initial_mode = "normal",
					-- disables netrw and use telescope-file-browser in its place
					hijack_netrw = true,
					previewer = false,
					layout_config = { height = 40 },
					mappings = {
						-- your custom insert mode mappings
						["i"] = {
							["<C-w>"] = function()
								vim.cmd("normal vbd")
							end,
						},
						["n"] = {
							-- your custom normal mode mappings
							["%"] = fb_actions.create,
							["-"] = fb_actions.goto_parent_dir,
						},
					},
				},
			},
		})

		telescope.load_extension("file_browser")

		bind("n", "<leader>ff", function()
			builtin.find_files({
				file_ignore_patterns = file_ignore_patterns,
				no_ignore = true,
				hidden = true,
			})
		end)
		bind("n", "<leader>r", function()
			builtin.live_grep({
				file_ignore_patterns = file_ignore_patterns,
				hidden = true,
			})
		end)
		bind("n", "<leader>*", function()
			builtin.grep_string({
				file_ignore_patterns = file_ignore_patterns,
				hidden = true,
			})
		end)
		bind("n", "<leader>gf", builtin.git_files)
		bind("n", "<leader>H", builtin.help_tags)
		bind("n", "<leader>qf", builtin.quickfix)
		bind("n", "<leader>km", builtin.keymaps)
		bind("n", "\\\\", builtin.buffers)
		bind("n", "<leader><leader>", builtin.resume)
		bind("n", "<leader>e", builtin.diagnostics)

		bind("n", "sf", telescope.extensions.file_browser.file_browser)
	end,
}
