return {
	"tpope/vim-fugitive",
	cmd = { "G", "Git", "Gedit", "Gdiffsplit", "Gvdiffsplit", "Gread", "Gwrite", "Gclog" },
	keys = {
		{ "<leader>gg", "<cmd>Git<cr>", desc = "Open Git summary (Fugitive)" },
		{ "<leader>gL", "<cmd>Git log --oneline<cr>", desc = "Show commit log (Fugitive)" },
	},
}
