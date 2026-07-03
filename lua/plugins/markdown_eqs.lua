return {
	"jbyuki/nabla.nvim",
	keys = {
		{
			"<leader>um",
			function()
				require("nabla").toggle_virt()
			end,
			desc = "Toggle math rendering",
		},
		{
			"<leader>up",
			function()
				require("nabla").popup()
			end,
			desc = "Preview math in popup",
		},
	},
}
