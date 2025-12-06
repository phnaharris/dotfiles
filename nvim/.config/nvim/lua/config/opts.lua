-- always set leader first!
vim.g.mapleader = " "

-------------------------------------------------------------------------------
--
-- preferences
--
-------------------------------------------------------------------------------
vim.opt.guicursor = ""
-- never ever folding
vim.opt.foldenable = false
vim.opt.foldmethod = "manual"
vim.opt.foldlevelstart = 99
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.wrap = false
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.numberwidth = 5
vim.opt.smartindent = true -- smart indent reacts to the syntax
vim.opt.tabstop = 4 -- 1 tab = 4 spaces
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4 -- the number of spaces inserted for each indentation
vim.opt.expandtab = true -- convert tabs to spaces
-- vim.opt.list = true
-- vim.opt.listchars = "tab:^ ,nbsp:¬,extends:»,precedes:«,trail:•"
vim.opt.inccommand = "split"
vim.opt.clipboard = "unnamedplus" -- yank to clipboard suck?
vim.opt.cursorline = true
vim.opt.termguicolors = true
vim.opt.pumblend = 5
vim.opt.colorcolumn = "+1"
vim.opt.textwidth = 80
vim.opt.timeoutlen = 500 -- time to wait for key mapping (in ms), default = 1000 ms
vim.opt.updatetime = 50 -- default = 4000
vim.opt.scrolloff = 8
vim.opt.undodir = os.getenv "HOME" .. "/.vim/undodir"
vim.opt.undofile = true
-- Decent wildmenu
vim.opt.wildignore:append { ".git/", ".cache/", "node_modules/", "target/" }
-- in completion, when there is more than one match,
-- list all matches, and only complete to longest common match
vim.opt.wildmode = "list:longest"
vim.opt.path:append { "**" } -- finding files - Search down into subfolders
vim.opt.iskeyword:append { "-" } -- treat dash separated words as a word text object
-- more useful diffs (nvim -d)
--- by ignoring whitespace
vim.opt.diffopt:append "iwhite"
--- and using a smarter algorithm
--- https://vimways.org/2018/the-power-of-diff/
--- https://stackoverflow.com/questions/32365271/whats-the-difference-between-git-diff-patience-and-git-diff-histogram
--- https://luppeng.wordpress.com/2020/10/10/when-to-use-each-of-the-git-diff-algorithms/
vim.opt.diffopt:append "algorithm:histogram"
vim.opt.diffopt:append "indent-heuristic"
-- show a column at 80 characters as a guide for long lines
vim.opt.colorcolumn = "80"
