local status, telescope = pcall(require, "telescope")
if (not status) then return end
local actions = require("telescope.actions")
local builtin = require("telescope.builtin")

local function telescope_buffer_dir()
    return vim.fn.expand("%:p:h")
end

local fb_actions = require "telescope".extensions.file_browser.actions

telescope.setup {
    defaults = {
        -- preview = {
        --     filesize_hook = function(filepath, bufnr, opts)
        --         local max_bytes = 10000
        --         local cmd = { "head", "-c", max_bytes, filepath }
        --         require("telescope.previewers.utils").job_maker(cmd, bufnr, opts)
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
        mappings = {
            n = {
                ["q"] = actions.close,
            },
        },
    },
    extensions = {
        file_browser = {
            theme = "dropdown",
            respect_gitignore = false,
            hidden = true,
            grouped = true,
            initial_mode = "normal",
            -- disables netrw and use telescope-file-browser in its place
            hijack_netrw = true,
            mappings = {
                -- your custom insert mode mappings
                ["i"] = {
                    ["<C-w>"] = function() vim.cmd("normal vbd") end,
                },
                ["n"] = {
                    -- your custom normal mode mappings
                    ["N"] = fb_actions.create,
                    ["-"] = fb_actions.goto_parent_dir,
                    ["/"] = function()
                        vim.cmd("startinsert")
                    end
                },
            },
        },
    },
}

telescope.load_extension("file_browser")

local file_ignore_patterns = {
    ".git/",
    "node_modules/",
    ".cache/",
    "**/target/"
}

local function telescope_keymaps()
    bind("n", "<leader>ff",
        function()
            builtin.find_files({
                file_ignore_patterns = file_ignore_patterns,
                no_ignore = true,
                hidden = true
            })
        end)
    bind("n", "<leader>gf", function() builtin.git_files({}) end)
    bind("n", "<leader>r",
        function()
            builtin.live_grep({
                file_ignore_patterns = file_ignore_patterns,
                hidden = true
            })
        end)
    bind("n", "<leader>*", function()
        builtin.grep_string({
            file_ignore_patterns = file_ignore_patterns,
            hidden = true
        })
    end)
    bind("n", "<leader>H", function() builtin.help_tags() end)
    bind("n", "<leader>qf", function() builtin.quickfix() end)
    bind("n", "<leader>km", function() builtin.keymaps() end)
    bind("n", "\\\\", function() builtin.buffers() end)
    bind("n", "<leader><leader>", function() builtin.resume() end)
    bind("n", "<leader>e", function() builtin.diagnostics() end)
    bind("n", "sf", function()
        telescope.extensions.file_browser.file_browser({
            path = "%:p:h",
            cwd = telescope_buffer_dir(),
            respect_gitignore = false,
            hidden = true,
            grouped = true,
            previewer = false,
            initial_mode = "normal",
            layout_config = { height = 40 }
        })
    end
    )
end

telescope_keymaps()
