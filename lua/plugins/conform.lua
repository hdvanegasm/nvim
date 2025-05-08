return {
	"stevearc/conform.nvim",
	cmd = "ConformInfo",
	event = { "BufWritePre" },
	keys = {
		{
			"<leader>cF",
			function()
				require("conform").format({ async = true })
			end,
			mode = "",
			desc = "Format buffer",
		},
	},
	---@module "conform"
	---@type conform.setupOpts
	opts = {
		format_on_save = {
			timeout_ms = 700,
		},
		default_format_opts = {
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
