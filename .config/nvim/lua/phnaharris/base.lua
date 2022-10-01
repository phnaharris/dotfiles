-- vim.opt.exrc = true -- Auto detect .nvimrc/.exrc -- It's not worked!?
vim.opt.shell = 'zsh'
vim.scriptencoding = 'utf-8'
vim.opt.encoding = 'utf-8'
vim.opt.fileencoding = 'utf-8'
vim.opt.wrap = false -- No wrap line

-- Split setting
vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.backup = false
vim.opt.backupskip = '/tmp/*, /private/tmp/*'
vim.opt.wildignore:append { '*/node_modules/*' }

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.numberwidth = 5

vim.opt.autoindent = true -- Auto indent to next line
vim.opt.smartindent = true -- Smart indent reacts to the syntax
vim.opt.tabstop = 4 -- 1 tab = 4 spaces
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.list = false -- Turn off dollar at end of line
vim.opt.hlsearch = true -- Highlight
vim.opt.mouse = 'a'
vim.opt.path:append { '**' } -- Finding files - Search down into subfolders
vim.opt.inccommand = 'split'

vim.opt.clipboard:append { 'unnamedplus' }
vim.opt.iskeyword:append { '-' } -- treat dash separated words as a word text object
