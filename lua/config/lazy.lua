-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end

vim.opt.rtp:prepend(lazypath)

-- Tabs look like 4 spaces
vim.opt.tabstop = 4
vim.opt.confirm = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.shiftwidth = 4
vim.opt.smartindent = true
vim.opt.undofile = true
vim.opt.scrolloff = 8

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- UI
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.opt.cursorline = true
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.pumborder = "rounded"
vim.opt.showmode = false -- mode is already shown by lualine

-- Folds (Tree-sitter foldexpr is set per buffer in treesitter.lua)
vim.opt.foldlevel = 99 -- start with every fold open; zM closes all, za toggles one
vim.opt.foldtext = "" -- show the fold's first line with its highlighting

-- Disable unused remote providers
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0

-- Register extra filetypes.
-- `mpc` gets its own filetype (not `python`) on purpose: the syntax only *looks*
-- like Python, so it borrows Python's highlighting in syntax/mpc.lua while
-- staying out of reach of the python LSP servers, formatters and parsers.
vim.filetype.add({ extension = { gotmpl = "gotmpl", mpc = "mpc" } })

-- Leaders setup
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
	spec = {
		-- import your plugins
		{ import = "plugins" },
	},
	-- colorscheme applied while plugins install on a fresh checkout
	install = { colorscheme = { "ember" } },
	-- no plugin here needs luarocks
	rocks = { enabled = false },
	-- automatically check for plugin updates
	checker = { enabled = false },
})
