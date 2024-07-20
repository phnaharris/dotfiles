return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    ---@diagnostic disable-next-line: missing-fields
    require("nvim-ts-autotag").setup {}
    local status, configs = pcall(require, "nvim-treesitter.configs")
    if not status then
      return
    end
    ---@diagnostic disable-next-line: missing-fields
    configs.setup {
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true },
    }
  end,
}
