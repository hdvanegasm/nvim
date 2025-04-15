return {
	"stevearc/conform.nvim",
	cmd = "ConformInfo",
	keys = {
		{
			"<leader>cF",
			function()
				require("conform").format({ bufnr = 0 })
			end,
			mode = { "n", "v" },
		},
	},
	opts = {
		format_on_save = {
			-- These options will be passed to conform.format()
			timeout_ms = 500,
			lsp_format = "fallback",
		},
		formatters_by_ft = {
			lua = { "stylua" },
			-- Conform will run multiple formatters sequentially
			python = { "isort", "black" },
			-- You can customize some of the format options for the filetype (:help conform.format)
			rust = { "rustfmt", lsp_format = "fallback" },
			-- Conform will run the first available formatter
			javascript = { "prettierd", "prettier", stop_after_first = true },
		},
		notify_on_error = true,
		notify_no_formaters = true,
	},
	config = function(_, opts)
		require("conform").setup(opts)
	end,
}
