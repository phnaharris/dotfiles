local on_attach = function(gs, bufnr)
  bind("n", "<leader>hs", gs.stage_hunk)
  bind("n", "<leader>hr", gs.reset_hunk)
  bind("v", "<leader>hs", function()
    gs.stage_hunk { vim.fn.line ".", vim.fn.line "v" }
  end)
  bind("v", "<leader>hr", function()
    gs.reset_hunk { vim.fn.line ".", vim.fn.line "v" }
  end)
  bind("n", "<leader>hS", gs.stage_buffer)
  bind("n", "<leader>hu", gs.undo_stage_hunk)
  bind("n", "<leader>hR", gs.reset_buffer)
  bind("n", "<leader>hp", gs.preview_hunk)
  bind("n", "<leader>hb", function()
    gs.blame_line { full = true }
  end)
  bind("n", "<leader>tb", gs.toggle_current_line_blame)
  bind("n", "<leader>hd", gs.diffthis)
  bind("n", "<leader>hD", function()
    gs.diffthis "~"
  end)
  bind("n", "<leader>td", gs.toggle_deleted)
end

return {
  "lewis6991/gitsigns.nvim",
  config = function()
    require("gitsigns").setup {
      on_attach = function(bufnr)
        on_attach(package.loaded.gitsigns, bufnr)
      end,
      -- current_line_blame = true,
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
        delay = 0,
        ignore_whitespace = false,
      },
    }
  end,
}
