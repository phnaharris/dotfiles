return {
	"ellisonleao/gruvbox.nvim",
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	lazy = false,
	priority = 1000,
	config = function()
		require("gruvbox").setup({
			contrast = "hard",
		})
		vim.cmd.colorscheme("gruvbox")
	end,
}
