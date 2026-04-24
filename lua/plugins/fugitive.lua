return {
	"tpope/vim-fugitive",
	lazy = false,
	keys = {
		{ "<leader>gg", "<cmd>Git<cr>", desc = "Git status (Fugitive)" },
		{ "<leader>gL", "<cmd>Git log --oneline<cr>", desc = "Git log" },
	},
}
