local options = {
    -- exrc = true, -- auto detect .nvimrc/.exrc -- It's not worked!?,
    shell = 'zsh',
    encoding = 'utf-8',
    fileencoding = 'utf-8',
    wrap = false, -- no wrap line
    -- split setting
    splitbelow = true,
    splitright = true,

    backup = false,
    backupskip = '/tmp/*, /private/tmp/*',
    swapfile = false,

    number = true,
    relativenumber = true,
    numberwidth = 5,

    autoindent = true, -- auto indent to next line
    smartindent = true, -- smart indent reacts to the syntax
    tabstop = 4, -- 1 tab = 4 spaces
    softtabstop = 4,
    shiftwidth = 4, -- the number of spaces inserted for each indentation
    expandtab = true, -- convert tabs to spaces

    list = false, -- turn off dollar at end of line
    hlsearch = true, -- highlight
    mouse = 'a',
    inccommand = 'split',
    clipboard = "unnamedplus",

    -- highlighting
    cursorline = true,
    termguicolors = true,
    pumblend = 5,

    timeoutlen = 500, -- time to wait for key mapping (in ms), default = 1000 ms
}


vim.opt.wildignore:append { '*/node_modules/*' }
vim.opt.path:append { '**' } -- finding files - Search down into subfolders
vim.opt.iskeyword:append { '-' } -- treat dash separated words as a word text object
vim.scriptencoding = 'utf-8'

-- Disable netrw
vim.g.loaded_netrw       = 1
vim.g.loaded_netrwPlugin = 1

vim.g.mapleader = ' '

for k, v in pairs(options) do
    vim.opt[k] = v
end
