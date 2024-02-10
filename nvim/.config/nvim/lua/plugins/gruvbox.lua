return {
	"RRethy/base16-nvim",
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	lazy = false,
	priority = 1000,
	config = function()
		vim.cmd.colorscheme("base16-gruvbox-dark-hard")
	end,
}
