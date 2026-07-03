return {
	"stevearc/conform.nvim",
	cmd = "ConformInfo",
	event = "BufWritePre",
	keys = {
		{
			"<leader>cf",
			function()
				require("conform").format({ async = true })
			end,
			mode = "",
			desc = "Format current buffer",
		},
	},
	---@module "conform"
	---@type conform.setupOpts
	opts = {
		format_on_save = function(bufnr)
			-- latexindent is too slow for on-save and reflows prose; format tex/bib manually with <leader>cf
			local ft = vim.bo[bufnr].filetype
			if ft == "tex" or ft == "plaintex" or ft == "bib" then
				return nil
			end
			return { timeout_ms = 700 }
		end,
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
			go = { "goimports", "gofmt" },
			c = { "clang-format" },
			cpp = { "clang-format" },
			markdown = { "prettier" },
			json = { "prettier" },
			jsonc = { "prettier" },
			toml = { "taplo" },
			tex = { "latexindent" },
			bib = { "latexindent" },
			sh = { "shfmt" },
			bash = { "shfmt" },
			fish = { "fish_indent" },
		},
		notify_on_error = true,
		notify_no_formatters = true,
	},
}
