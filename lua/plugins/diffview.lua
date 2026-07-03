return {
	"sindrets/diffview.nvim",
	cmd = { "DiffviewOpen", "DiffviewFileHistory", "DiffviewClose" },
	keys = {
		{
			"<leader>gd",
			"<cmd>DiffviewOpen<CR>",
			desc = "Open diff view (working tree)",
		},
		{
			"<leader>gc",
			"<cmd>DiffviewClose<CR>",
			desc = "Close diff view",
		},
	},
	opts = {},
}
