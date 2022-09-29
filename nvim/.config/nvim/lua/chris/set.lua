vim.opt.clipboard = "unnamedplus"

vim.opt.shell = "/bin/zsh"

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.errorbells = false

vim.opt.autoindent = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2

vim.opt.wrap = false

vim.opt.smartcase = true

vim.opt.swapfile = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true
vim.opt.backup = false

vim.opt.scrolloff = 8

vim.opt.incsearch = true
vim.opt.hlsearch = true

vim.opt.colorcolumn= "100"

vim.opt.termguicolors = true

vim.opt.ignorecase = true

vim.opt.list = true

vim.opt.laststatus = 3

vim.opt.spell = true

vim.opt.splitright = true

vim.g.mapleader = " "

-- TODO: This lua opt does seem to work
-- vim.opt.mouse = a
vim.cmd [[set mouse=a]]

-- Netrw
vim.g.netrw_liststyle = 3
vim.g.netrw_banner = 0
vim.g.netrw_bufsettings = 'noma nomod nu nobl nowrap ro'

-- NERDTree
vim.g.NERDTreeShowHidden = 1
vim.g.NERDTreeChDirMode = 2

-- Enable line numbers
vim.g.NERDTreeShowLineNumbers = 1

-- Make sure relative line numbers are used
-- TODO Figure out autocommands
-- autocmd FileType nerdtree setlocal relativenumber

-- Rspec runner
vim.g.rspec_command = "!bundle exec rspec {spec} --format progress --require $HOME/.local/bin/quickfix_formatter.rb --format QuickfixFormatter --out /tmp/quickfix.out"

-- Add command to call formatter
vim.api.nvim_create_user_command('Format', ':Neoformat', {})

-- TODO 
-- command ClearReg call EmptyRegisters() " Clear the reg

-- Emmet
vim.g.user_emmet_leader_key='<C-,>'
