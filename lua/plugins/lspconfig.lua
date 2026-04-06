return {
	"neovim/nvim-lspconfig",
	dependencies = { "saghen/blink.cmp" },
	opts = {
		servers = {
			lua_ls = {},
			clangd = {
				cmd = {
					"clangd",
					"--background-index",
					"--clang-tidy",
					"--header-insertion=iwyu",
					"--completion-style=detailed",
					"--function-arg-placeholders",
					"--fallback-style=llvm",
				},
				init_options = {
					usePlaceholders = true,
					completeUnimported = true,
					clangdFileStatus = true,
				},
				keys = {
					{ "<leader>ch", "<cmd>ClangdSwitchSourceHeader<cr>", desc = "Switch Source/Header (C/C++)" },
				},
			},
			gopls = {
				settings = {
					gopls = {
						gofumpt = true,
						hints = {
							assignVariableTypes = true,
							compositeLiteralFields = true,
							compositeLiteralTypes = true,
							constantValues = true,
							functionTypeParameters = true,
							parameterNames = true,
							rangeVariableTypes = true,
						},
						analyses = {
							nilness = true,
							unusedparams = true,
							unusedwrite = true,
							useany = true,
						},
						usePlaceholders = true,
						completeUnimported = true,
						staticcheck = true,
						semanticTokens = true,
					},
				},
			},
			rust_analyzer = {
				settings = {
					["rust-analyzer"] = {
						diagnostics = {
							enable = true,
						},
						semanticHighlighting = {
							strings = true,
						},
					},
				},
			},
			texlab = {},
			ruff = {},
			basedpyright = {
				settings = {
					basedpyright = {
						disableOrganizeImports = true,
						analysis = {
							ignore = { "*" },
						},
					},
				},
			},
			marksman = {},
			neocmake = {},
			taplo = {},
			jsonls = {},
		},
	},
	config = function(_, opts)
		local map = function(keys, func, desc, mode)
			mode = mode or "n"
			vim.keymap.set(mode, keys, func, { desc = "LSP: " .. desc })
		end

		map("gd", require("telescope.builtin").lsp_definitions, "Go to definition")
		map("gr", require("telescope.builtin").lsp_references, "Go to references")
		map("gI", require("telescope.builtin").lsp_implementations, "Goto Implementation")
		map("gy", require("telescope.builtin").lsp_type_definitions, "Goto T[y]pe Definition")
		map("gD", vim.lsp.buf.declaration, "Goto Declaration")
		map("<leader>cr", vim.lsp.buf.rename, "Rename")
		map("K", function()
			return vim.lsp.buf.hover()
		end, "Hover")
		map("gK", function()
			return vim.lsp.buf.signature_help()
		end, "Signature Help")
		map("gra", vim.lsp.buf.code_action, "Code Action", { "n", "v" })
		map("gO", require("telescope.builtin").lsp_document_symbols, "Document Symbols")

		if vim.lsp.inlay_hint then
			-- Enable inlay hints globally.
			vim.lsp.inlay_hint.enable(true)

			-- Toggle inlay hints.
			map("<leader>ci", function()
				vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = 0 }), { bufnr = 0 })
			end, "Toggle Inlay Hints")
		end

		vim.diagnostic.config({
			virtual_text = {
				prefix = "■",
				spacing = 4,
			},
			underline = false,
			severity_sort = true, -- Sort diagnostics by severity
			float = {
				border = "rounded", -- 'single', 'double', 'rounded', etc
				source = "always", -- Show source in floating window
			},
		})

		for server, config in pairs(opts.servers) do
			config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
			vim.lsp.config(server, config)
			vim.lsp.enable(server)
		end
	end,
}
