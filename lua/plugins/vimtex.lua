return {
	"lervag/vimtex",
	lazy = false,
	init = function()
		-- zathura_simple skips xdotool window-ID tracking, which fails on Wayland (Sway)
		vim.g.vimtex_view_method = "zathura_simple"
		vim.g.vimtex_compiler_method = "latexmk"
		vim.g.vimtex_compiler_latexmk = {
			options = {
				"-pdf",
				"-interaction=nonstopmode",
				"-synctex=1",
			},
		}
		-- Don't auto-open the quickfix window for warnings, only for errors
		vim.g.vimtex_quickfix_open_on_warning = 0
		-- Ignore common noisy warnings in the quickfix list
		vim.g.vimtex_quickfix_ignore_filters = {
			"Underfull \\\\hbox",
			"Overfull \\\\hbox",
		}
		-- VimTeX owns LaTeX syntax highlighting. Its `$`/math text objects
		-- (i$, a$), delimiter tools and conceal all read VimTeX's own syntax
		-- groups, so Tree-sitter is kept off tex buffers (see treesitter.lua)
		-- and conceal is switched on via conceallevel (after/ftplugin/tex.lua).
		-- vimtex_syntax_enabled defaults to 1 and is intentionally left unset;
		-- do NOT set it to 0 or the `$` text objects recurse (E132).
		-- Let texlab handle completion via blink.cmp
		vim.g.vimtex_complete_enabled = 0
	end,
}
