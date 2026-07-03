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
			{ "<leader>h", group = "harpoon" },
			{ "<leader>u", group = "ui/toggle" },
			{ "g", group = "goto" },
			{ "gr", group = "lsp" },
			{ "gz", group = "surround" },
			{ "[", group = "prev" },
			{ "]", group = "next" },
		},
	},
}
