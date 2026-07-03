return {
	"folke/todo-comments.nvim",
	event = { "BufReadPost", "BufNewFile" },
	dependencies = { "nvim-lua/plenary.nvim" },
	keys = {
		{
			"]t",
			function()
				require("todo-comments").jump_next()
			end,
			desc = "Next TODO/FIXME comment",
		},
		{
			"[t",
			function()
				require("todo-comments").jump_prev()
			end,
			desc = "Previous TODO/FIXME comment",
		},
		{ "<leader>xt", "<cmd>Trouble todo toggle<cr>", desc = "List TODO comments" },
		{ "<leader>ft", "<cmd>TodoTelescope<cr>", desc = "Search TODO comments" },
	},
	opts = {},
}
