vim.wo.number = true -- Enable line numbers 
vim.o.relativenumber = true -- Set relative line numbers

vim.o.mouse = 'a'

vim.o.tabstop = 4 -- Insert 4 spaces for  tab
vim.o.softtabstop = 4 -- Spaces for tab during editing 
vim.o.shiftwidth = 4 -- 4 spaces for each indentation 
vim.o.expandtab = true -- Convert tab to spaces 
vim.o.autoindent = true -- Auto indentation 
vim.o.smartcase = true 
vim.o.ignorecase = true -- Case-insensitive 
vim.o.smartindent = true

vim.wo.wrap = false -- Display long lines as one line
vim.o.linebreak = false
vim.o.scrolloff = 4
vim.o.sidescrolloff = 10

vim.o.cursorline = false
vim.o.splitbelow = true 
vim.o.splitright = true 

vim.o.hlsearch = true 
vim.o.showmode = true 
vim.o.incsearch = true
vim.o.inccommand = "split"
vim.opt.iskeyword:append '-'

vim.o.swapfile = false
vim.o.backup = false
vim.o.undofile = true

vim.opt.termguicolors = true
vim.o.signcolumn = "yes"

vim.o.backspace = 'start,eol,indent'

vim.o.updatetime = 50
vim.o.updatetime = 50
vim.o.colorcolumn = "80"

vim.o.clipboard = "unnamedplus"

vim.o.completeopt = 'menuone,noselect' -- set completeopt to have better completions

vim.o.fileencoding = 'utf-8'


