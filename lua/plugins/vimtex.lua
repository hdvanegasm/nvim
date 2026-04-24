return {
	"lervag/vimtex",
	lazy = false,
	init = function()
		vim.g.vimtex_view_method = "zathura"
		vim.g.vimtex_compiler_method = "latexmk"
		vim.g.vimtex_compiler_latexmk = {
			options = {
				"-pdf",
				"-interaction=nonstopmode",
				"-synctex=1",
			},
		}
		-- Let treesitter handle syntax highlighting
		vim.g.vimtex_syntax_enabled = 0
		-- Let texlab handle completion via blink.cmp
		vim.g.vimtex_complete_enabled = 0
	end,
}
