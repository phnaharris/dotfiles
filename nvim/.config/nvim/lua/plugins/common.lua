return {
  {
    "tpope/vim-surround",
    "tpope/vim-fugitive",
  },
  {
    "windwp/nvim-autopairs",
    opts = { disable_filetype = { "TelescopePrompt", "vim" } },
  },
  {
    "mbbill/undotree",
    keys = { "<leader>u", "<cmd>UndotreeToggle<CR>", desc = "Undotree" },
  },
}
