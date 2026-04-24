return {
	"j-hui/fidget.nvim",
	lazy = false,
	opts = {
		notification = {
			window = {
				relative = "editor",
			},
		},
	},
	config = function(_, opts)
		local fidget = require("fidget")
		fidget.setup(opts)
		vim.notify = fidget.notify
	end,
}
