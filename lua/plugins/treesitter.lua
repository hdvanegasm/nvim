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
				"go",
				"gomod",
				"gowork",
				"gosum",
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
				"toml",
				"vim",
				"vimdoc",
				"xml",
				"yaml",
			})

			-- Enable treesitter highlighting and indentation for all installed parsers
			-- (on the main branch, indentation must be opted into via indentexpr)
			vim.api.nvim_create_autocmd("FileType", {
				callback = function(args)
					if pcall(vim.treesitter.start, args.buf) then
						vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
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
			map({ "n", "x", "o" }, "]c", function()
				move.goto_next_start("@class.outer")
			end, { desc = "Next class start" })
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
				move.goto_previous_start("@class.outer")
			end, { desc = "Previous class start" })
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
