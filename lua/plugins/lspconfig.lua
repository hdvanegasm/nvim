return {
	"neovim/nvim-lspconfig",
	dependencies = { "saghen/blink.cmp" },
	keys = {
		{ "gd", vim.lsp.buf.definition, desc = "Goto Definition", has = "definition" },
		{ "gr", vim.lsp.buf.references, desc = "References", nowait = true },
		{ "gI", vim.lsp.buf.implementation, desc = "Goto Implementation" },
		{ "gy", vim.lsp.buf.type_definition, desc = "Goto T[y]pe Definition" },
		{ "gD", vim.lsp.buf.declaration, desc = "Goto Declaration" },
		{
			"K",
			function()
				return vim.lsp.buf.hover()
			end,
			desc = "Hover",
		},
		{
			"gK",
			function()
				return vim.lsp.buf.signature_help()
			end,
			desc = "Signature Help",
			has = "signatureHelp",
		},
		{ "<leader>ca", vim.lsp.buf.code_action, desc = "Code Action", mode = { "n", "v" }, has = "codeAction" },
		{ "<leader>cr", vim.lsp.buf.rename, desc = "Rename", has = "rename" },
	},
	opts = {
		servers = {
			lua_ls = {},
			clangd = {},
			gopls = {},
			rust_analyzer = {},
		},
	},
	config = function(_, opts)
		local lspconfig = require("lspconfig")
		for server, config in pairs(opts.servers) do
			config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
			lspconfig[server].setup(config)
		end
	end,
}
