local status, gitsigns = pcall(require, "gitsigns")
if (not status) then return end

local function on_attach(bufnr)
    bind("n", "<leader>gb", gitsigns.toggle_current_line_blame)
    bind("n", "<leader>gl", function()
        gitsigns.blame_line { full = true }
    end)
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
