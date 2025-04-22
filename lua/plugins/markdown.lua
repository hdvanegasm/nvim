return {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons

    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {
		completions = { lsp = { enabled = true } },
	},
	config = function (_, opts)
		require("render-markdown").setup(opts)
	end
}
