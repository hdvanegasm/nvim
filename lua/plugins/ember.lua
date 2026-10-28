return {
	"ember-theme/nvim",
	name = "ember",
	lazy = false,
	priority = 1000,
	config = function()
		require("ember").setup({
			variant = "ember", -- "ember" | "ember-soft" | "ember-light"
		})

		-- Concealed glyphs (α, ∫, fraction bars, …) are painted with the global
		-- `Conceal` group, not the underlying math color; ember leaves it a dim
		-- gray. Match the formula color instead: ember highlights math via
		-- texMathZone -> Special (the orange #E08060), so linking Conceal to
		-- Special makes concealed symbols that same orange and tracks the theme.
		-- Re-applied on every colorscheme load so it survives theme reloads.
		vim.api.nvim_create_autocmd("ColorScheme", {
			group = vim.api.nvim_create_augroup("user-conceal-hl", { clear = true }),
			callback = function()
				vim.api.nvim_set_hl(0, "Conceal", { link = "Special" })
			end,
		})

		vim.cmd("colorscheme ember")
	end,
}
