return {
	"neovim/nvim-lspconfig",
	dependencies = { "saghen/blink.cmp" },
	opts = {
		servers = {
			lua_ls = {},
			clangd = {
				cmd = { "clangd", "--limit-references=0", "--limit-results=0" },
			},
			gopls = {},
			rust_analyzer = {},
		},
	},
	config = function(_, opts)
		local map = function(keys, func, desc, mode)
			mode = mode or "n"
			vim.keymap.set(mode, keys, func, { desc = "LSP: " .. desc })
		end

		map("gd", vim.lsp.buf.definition, "Go to definition")
		map("gr", vim.lsp.buf.references, "Go to references")
		map("gI", vim.lsp.buf.implementation, "Goto Implementation")
		map("gy", vim.lsp.buf.type_definition, "Goto T[y]pe Definition")
		map("gD", vim.lsp.buf.declaration, "Goto Declaration")
		map("K", function()
			return vim.lsp.buf.hover()
		end, "Hover")
		map("gK", function()
			return vim.lsp.buf.signature_help()
		end, "Signature Help")

		if vim.lsp.inlay_hint then
			-- Enable inlay hints.
			vim.lsp.inlay_hint.enable(true, { 0 })

			-- Toggle inlay hints.
			map("ch", function()
				if vim.lsp.inlay_hint.is_enabled() then
					vim.lsp.inlay_hint.enable(false, { bufnr })
				else
					vim.lsp.inlay_hint.enable(true, { bufnr })
				end
			end, "Toggle Inlay Hints")
		end

		vim.diagnostic.config({
			virtual_text = {
				prefix = "■",
				spacing = 4,
			},
			signs = false,
			underline = false,
			severity_sort = true, -- Sort diagnostics by severity
			float = {
				border = "rounded", -- 'single', 'double', 'rounded', etc
				source = "always", -- Show source in floating window
			},
		})

		local lspconfig = require("lspconfig")
		for server, config in pairs(opts.servers) do
			config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
			lspconfig[server].setup(config)
		end
	end,
}
