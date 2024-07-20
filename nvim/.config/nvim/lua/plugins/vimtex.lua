return {
  "lervag/vimtex",
  keys = {
    { "<leader>vc", "<cmd>VimtexCompile<CR>", desc = "VimTex continous compiling" },
    { "<leader>vv", "<cmd>VimtexView<CR>", desc = "VimTex viewing document" },
    { "<leader>vi", "<cmd>VimtexInfo<CR>", desc = "VimTex showing document information" },
  },
  lazy = false,
  config = function()
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
  end,
}
