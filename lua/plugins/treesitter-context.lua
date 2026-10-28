return {
	"nvim-treesitter/nvim-treesitter-context",
	event = { "BufReadPost", "BufNewFile" },
	opts = {
		-- cap the pinned context so deep nesting can't eat the window
		max_lines = 4,
	},
}
