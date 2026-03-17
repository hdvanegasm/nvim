return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		spec = {
			{ "<leader>c", group = "code" },
			{ "<leader>f", group = "find" },
			{ "<leader>x", group = "diagnostics" },
			{ "<leader>b", group = "buffer" },
			{ "<leader>g", group = "git" },
			{ "g", group = "goto" },
			{ "[", group = "prev" },
			{ "]", group = "next" },
		},
	},
}
