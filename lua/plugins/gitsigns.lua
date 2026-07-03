return {
	"lewis6991/gitsigns.nvim",
	event = "BufReadPre",
	opts = {
		on_attach = function(bufnr)
			local gs = require("gitsigns")
			local map = function(mode, l, r, desc)
				vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
			end

			-- Navigation
			map("n", "]h", function()
				gs.nav_hunk("next")
			end, "Next Git hunk")
			map("n", "[h", function()
				gs.nav_hunk("prev")
			end, "Previous Git hunk")

			-- Actions (stage_hunk toggles: on a staged hunk it unstages)
			map("n", "<leader>gs", gs.stage_hunk, "Stage / unstage hunk under cursor")
			map("n", "<leader>gr", gs.reset_hunk, "Discard hunk under cursor")
			map("v", "<leader>gs", function()
				gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end, "Stage selected lines")
			map("v", "<leader>gr", function()
				gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end, "Discard selected lines")
			map("n", "<leader>gS", gs.stage_buffer, "Stage whole buffer")
			map("n", "<leader>gR", gs.reset_buffer, "Discard all buffer changes")
			map("n", "<leader>gp", gs.preview_hunk, "Preview hunk diff")
			map("n", "<leader>gi", gs.preview_hunk_inline, "Preview hunk inline")
			map("n", "<leader>gb", gs.blame_line, "Blame current line")
			map("n", "<leader>gB", function()
				gs.blame_line({ full = true })
			end, "Blame current line (full)")
			map("n", "<leader>gt", gs.toggle_current_line_blame, "Toggle inline blame")
		end,
	},
}
