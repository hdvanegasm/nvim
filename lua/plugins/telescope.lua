return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	dependencies = { "nvim-lua/plenary.nvim" },
	keys = {
		{ "<leader>ff", require("telescope.builtin").find_files, desc = "Find files" },
		{ "<leader>fg", require("telescope.builtin").live_grep, desc = "Live grep" },
		{ "<leader>fb", require("telescope.builtin").buffers, desc = "Buffers" },
		{ "<leader>fh", require("telescope.builtin").help_tags, desc = "Help tags" },
	},
	opts = {},
}
