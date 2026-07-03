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
						cachePriming = {
							numThreads = 3,
						},
					},
				},
			},
			texlab = {
				settings = {
					texlab = {
						-- Lint with chktex (dnf: texlive-chktex)
						chktex = {
							onOpenAndSave = true,
							onEdit = false,
						},
						diagnosticsDelay = 300,
						latexFormatter = "latexindent",
						latexindent = {
							modifyLineBreaks = false,
						},
					},
				},
			},
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
			bashls = {},
			fish_lsp = {},
			solidity_ls_nomicfoundation = {},
		},
	},
	config = function(_, opts)
		-- Buffer-local keymaps, only where a server is attached.
		-- grn=rename, gra=code_action, K=hover are 0.12 defaults and left untouched.
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("user-lsp-attach", { clear = true }),
			callback = function(event)
				local map = function(keys, func, desc, mode)
					mode = mode or "n"
					vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
				end

				-- Telescope-enhanced LSP navigation (overrides defaults with fuzzy picker)
				map("gd", function()
					require("telescope.builtin").lsp_definitions()
				end, "Go to definition")
				map("grr", function()
					require("telescope.builtin").lsp_references()
				end, "List references")
				map("gri", function()
					require("telescope.builtin").lsp_implementations()
				end, "Go to implementation")
				map("grt", function()
					require("telescope.builtin").lsp_type_definitions()
				end, "Go to type definition")
				map("gO", function()
					require("telescope.builtin").lsp_document_symbols()
				end, "Search document symbols")

				map("grx", vim.lsp.codelens.run, "Run code lens")
				map("gD", vim.lsp.buf.declaration, "Go to declaration")
				map("gK", vim.lsp.buf.signature_help, "Show signature help")

				local client = vim.lsp.get_client_by_id(event.data.client_id)
				if client and client.name == "clangd" then
					map("<leader>ch", "<cmd>LspClangdSwitchSourceHeader<cr>", "Switch source / header (C/C++)")
				end
			end,
		})

		-- Inlay hints
		vim.lsp.inlay_hint.enable(true)
		vim.keymap.set("n", "<leader>uh", function()
			vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = 0 }), { bufnr = 0 })
		end, { desc = "LSP: Toggle inlay hints" })

		vim.diagnostic.config({
			virtual_text = {
				prefix = "■",
				spacing = 4,
			},
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = " ",
					[vim.diagnostic.severity.WARN] = " ",
					[vim.diagnostic.severity.INFO] = " ",
					[vim.diagnostic.severity.HINT] = " ",
				},
			},
			underline = false,
			severity_sort = true, -- Sort diagnostics by severity
			float = {
				border = "rounded", -- 'single', 'double', 'rounded', etc
				source = true, -- Show source in floating window
			},
		})

		for server, config in pairs(opts.servers) do
			config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
			vim.lsp.config(server, config)
			vim.lsp.enable(server)
		end
	end,
}
