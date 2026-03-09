return {
	"ellisonleao/gruvbox.nvim",
	priority = 1000,
	lazy = false,
	opts = {},
	config = function()
		vim.o.background = "dark" -- or "light" for light mode
		vim.cmd([[colorscheme gruvbox]])
	end,
}
