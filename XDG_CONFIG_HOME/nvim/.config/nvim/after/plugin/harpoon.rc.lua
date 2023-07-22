local status, harpoon = pcall(require, "harpoon")
if (not status) then return end

local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

harpoon.setup()

bind("n", "<leader>ha", mark.add_file)
bind("n", "<leader>hh", ui.toggle_quick_menu)

bind("n", "<leader>hj", function() ui.nav_file(1) end)
bind("n", "<leader>hk", function() ui.nav_file(2) end)
bind("n", "<leader>hl", function() ui.nav_file(3) end)
bind("n", "<leader>h;", function() ui.nav_file(4) end)
