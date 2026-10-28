return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		build = ":TSUpdate",
		lazy = false,
		config = function()
			require("nvim-treesitter").install({
				"bash",
				"bibtex",
				"c",
				"cpp",
				"cmake",
				"diff",
				"fish",
				"gitcommit",
				"git_rebase",
				"go",
				"gomod",
				"gowork",
				"gosum",
				"gotmpl",
				"html",
				"haskell",
				"javascript",
				"json",
				"latex",
				"lua",
				"luadoc",
				"luap",
				"markdown",
				"markdown_inline",
				"printf",
				"python",
				"query",
				"regex",
				"rust",
				"solidity",
				"toml",
				"vim",
				"vimdoc",
				"xml",
				"yaml",
			})

			-- Enable treesitter highlighting and indentation for all installed parsers
			-- (on the main branch, indentation must be opted into via indentexpr)
			vim.api.nvim_create_autocmd("FileType", {
				group = vim.api.nvim_create_augroup("user-treesitter-start", { clear = true }),
				callback = function(args)
					-- LaTeX highlighting and indentation are owned by VimTeX: its
					-- `$`/math text objects, delimiter tools and conceal need
					-- VimTeX's own syntax groups, and running Tree-sitter on top
					-- clashes (double highlighting, broken i$/a$). The `latex`
					-- parser stays installed above so math injected into markdown
					-- still highlights; it just isn't started for tex buffers.
					if args.match == "tex" then
						return
					end
					if pcall(vim.treesitter.start, args.buf) then
						vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
						-- Syntax-aware folds; foldlevel=99 (lazy.lua) keeps them open on load
						vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
						vim.wo[0][0].foldmethod = "expr"
					end
				end,
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		branch = "main",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			-- lookahead: `vif`/`daf` jump forward to the next function when the
			-- cursor isn't already inside one (default only works from inside)
			require("nvim-treesitter-textobjects").setup({ select = { lookahead = true } })

			local move = require("nvim-treesitter-textobjects.move")
			local select = require("nvim-treesitter-textobjects.select")

			local map = vim.keymap.set

			-- Select textobjects: around/inside function, class, parameter
			local select_maps = {
				af = { "@function.outer", "Around function" },
				["if"] = { "@function.inner", "Inside function" },
				ac = { "@class.outer", "Around class" },
				ic = { "@class.inner", "Inside class" },
				aa = { "@parameter.outer", "Around parameter" },
				ia = { "@parameter.inner", "Inside parameter" },
			}
			for lhs, target in pairs(select_maps) do
				map({ "x", "o" }, lhs, function()
					select.select_textobject(target[1], "textobjects")
				end, { desc = target[2] })
			end
			map({ "n", "x", "o" }, "]f", function()
				move.goto_next_start("@function.outer")
			end, { desc = "Next function start" })
			map({ "n", "x", "o" }, "]F", function()
				move.goto_next_end("@function.outer")
			end, { desc = "Next function end" })
			-- ]c/[c keep their built-in "jump to change" meaning in diff buffers
			-- (fugitive/diffview); elsewhere they move between classes
			map({ "n", "x", "o" }, "]c", function()
				if vim.wo.diff then
					vim.cmd.normal({ vim.v.count1 .. "]c", bang = true })
				else
					move.goto_next_start("@class.outer")
				end
			end, { desc = "Next class start (next change in diff)" })
			map({ "n", "x", "o" }, "]C", function()
				move.goto_next_end("@class.outer")
			end, { desc = "Next class end" })
			map({ "n", "x", "o" }, "]a", function()
				move.goto_next_start("@parameter.inner")
			end, { desc = "Next parameter start" })
			map({ "n", "x", "o" }, "]A", function()
				move.goto_next_end("@parameter.inner")
			end, { desc = "Next parameter end" })

			map({ "n", "x", "o" }, "[f", function()
				move.goto_previous_start("@function.outer")
			end, { desc = "Previous function start" })
			map({ "n", "x", "o" }, "[F", function()
				move.goto_previous_end("@function.outer")
			end, { desc = "Previous function end" })
			map({ "n", "x", "o" }, "[c", function()
				if vim.wo.diff then
					vim.cmd.normal({ vim.v.count1 .. "[c", bang = true })
				else
					move.goto_previous_start("@class.outer")
				end
			end, { desc = "Previous class start (previous change in diff)" })
			map({ "n", "x", "o" }, "[C", function()
				move.goto_previous_end("@class.outer")
			end, { desc = "Previous class end" })
			map({ "n", "x", "o" }, "[a", function()
				move.goto_previous_start("@parameter.inner")
			end, { desc = "Previous parameter start" })
			map({ "n", "x", "o" }, "[A", function()
				move.goto_previous_end("@parameter.inner")
			end, { desc = "Previous parameter end" })
		end,
	},
}
