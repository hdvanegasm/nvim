return {
	"sindrets/diffview.nvim",
	lazy = true,
	cmd = { "DiffviewOpen", "DiffviewFileHistory", "DiffviewClose" },
	keys = {
		{
			"<leader>gd",
			"<cmd>DiffviewOpen<CR>",
			desc = "Open diff view",
		},
	},
	config = function(_, opts)
		require("diffview").setup(opts)
		-- GitHub-style diff colors (dark theme)
		vim.api.nvim_set_hl(0, "DiffAdd", { bg = "#0d4429" })
		vim.api.nvim_set_hl(0, "DiffDelete", { bg = "#4d1a1f", fg = "#6e7681" })
		vim.api.nvim_set_hl(0, "DiffChange", { bg = "#0d2d38" })
		vim.api.nvim_set_hl(0, "DiffText", { bg = "#0c4a6e", bold = true })
	end,
}
