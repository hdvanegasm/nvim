return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		spec = {
			{ "<leader>c", group = "code" },
			{ "<leader>f", group = "find" },
			{ "<leader>x", group = "diagnostics" },
			{ "<leader>b", group = "buffer" },
			{ "<leader>d", group = "debug" },
			{ "<leader>g", group = "git" },
			{ "<leader>n", group = "no-neck-pain" },
			{ "g", group = "goto" },
			{ "gr", group = "lsp" },
			{ "[", group = "prev" },
			{ "]", group = "next" },
		},
	},
}
