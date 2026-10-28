return {
	"folke/flash.nvim",
	event = "VeryLazy",
	---@type Flash.Config
	opts = {
		highlight = {
			backdrop = true,
		},
	},
	config = function(_, opts)
		require("flash").setup(opts)
		-- ember doesn't define FlashLabel; re-apply on ColorScheme so it survives theme reloads
		local function label_hl()
			vim.api.nvim_set_hl(0, "FlashLabel", {
				fg = "#ffffff",
				bg = "#1a6b2d",
				bold = true,
			})
		end
		label_hl()
		vim.api.nvim_create_autocmd("ColorScheme", {
			group = vim.api.nvim_create_augroup("user-flash-label", { clear = true }),
			callback = label_hl,
		})
	end,
	keys = {
		{
			"s",
			mode = { "n", "x", "o" },
			function()
				require("flash").jump()
			end,
			desc = "Flash jump to text",
		},
		{
			"S",
			mode = { "n", "x", "o" },
			function()
				require("flash").treesitter()
			end,
			desc = "Flash select treesitter node",
		},
		{
			"r",
			mode = "o",
			function()
				require("flash").remote()
			end,
			desc = "Remote flash (operator)",
		},
		{
			"R",
			mode = { "o", "x" },
			function()
				require("flash").treesitter_search()
			end,
			desc = "Flash treesitter search",
		},
		{
			"<c-s>",
			mode = { "c" },
			function()
				require("flash").toggle()
			end,
			desc = "Toggle flash while searching",
		},
	},
}
