return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		build = ":TSUpdate",
		lazy = false,
		config = function()
			require("nvim-treesitter").install({
				"bash",
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
			vim.api.nvim_create_autocmd("FileType", {
				callback = function(args)
					pcall(vim.treesitter.start, args.buf)
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

			local map = vim.keymap.set
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
			end, { desc = "Next parameter" })
			map({ "n", "x", "o" }, "]A", function()
				move.goto_next_end("@parameter.inner")
			end, { desc = "Next parameter end" })

			map({ "n", "x", "o" }, "[f", function()
				move.goto_previous_start("@function.outer")
			end, { desc = "Prev function start" })
			map({ "n", "x", "o" }, "[F", function()
				move.goto_previous_end("@function.outer")
			end, { desc = "Prev function end" })
			map({ "n", "x", "o" }, "[c", function()
				move.goto_previous_start("@class.outer")
			end, { desc = "Prev class start" })
			map({ "n", "x", "o" }, "[C", function()
				move.goto_previous_end("@class.outer")
			end, { desc = "Prev class end" })
			map({ "n", "x", "o" }, "[a", function()
				move.goto_previous_start("@parameter.inner")
			end, { desc = "Prev parameter" })
			map({ "n", "x", "o" }, "[A", function()
				move.goto_previous_end("@parameter.inner")
			end, { desc = "Prev parameter end" })
		end,
	},
}
