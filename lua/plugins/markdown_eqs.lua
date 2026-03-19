return {
	"jbyuki/nabla.nvim",
	keys = {
		{
			"<leader>m",
			function()
				require("nabla").toggle_virt()
			end,
			desc = "Toggle math rendering",
		},
		{
			"<leader>p",
			function()
				require("nabla").popup()
			end,
			desc = "Preview math in popup",
		},
	},
}
