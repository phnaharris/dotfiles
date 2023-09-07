local status, gitsigns = pcall(require, "gitsigns")
if (not status) then return end

local function on_attach(bufnr)
    bind("n", "<leader>gb", gitsigns.toggle_current_line_blame)
    bind("n", "<leader>gl", function()
        gitsigns.blame_line { full = true }
    end)

    bind("n", "<leader>hs", gitsigns.stage_hunk)
    bind("n", "<leader>hu", gitsigns.undo_stage_hunk)
    bind("n", "<leader>hr", gitsigns.reset_hunk)
    bind("n", "<leader>hp", gitsigns.preview_hunk)
    bind("n", "<leader>hS", gitsigns.stage_buffer)
    bind("n", "<leader>hR", gitsigns.reset_buffer)

    bind("v", "<leader>hs",
        function() gitsigns.stage_hunk { vim.fn.line("."), vim.fn.line("v") } end)
    bind("v", "<leader>hr",
        function() gitsigns.reset_hunk { vim.fn.line("."), vim.fn.line("v") } end)
end

gitsigns.setup({
    on_attach = on_attach,

    -- current_line_blame = true,
    current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
        delay = 0,
        ignore_whitespace = false,
    },
})
