return {
  "tpope/vim-surround",
  {
    "tpope/vim-fugitive",
    dependencies = {
      "wcascades/vim-fugitive-toggle",
    },
    config = function()
      bind("n", "<M-g>", "<cmd>lua require('vim-fugitive-toggle').toggle()<cr>")
    end,
  },
  "h-hg/fcitx.nvim",
  { "j-hui/fidget.nvim", config = true },
  { "windwp/nvim-ts-autotag", config = true },
  {
    "mbbill/undotree",
    keys = { "<leader>u", "<cmd>UndotreeToggle<CR>", desc = "Undotree" },
  },
}
