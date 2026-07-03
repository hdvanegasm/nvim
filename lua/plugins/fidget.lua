return {
	"j-hui/fidget.nvim",
	event = "VeryLazy",
	opts = {
		notification = {
			override_vim_notify = true,
			window = {
				winblend = 0, -- opaque background (default 100 is fully transparent)
				normal_hl = "Normal", -- regular text color instead of dim Comment grey
			},
		},
		progress = {
			ignore_done_already = true, -- drop progress messages that arrive already finished
			suppress_on_insert = true, -- don't animate the spinner while typing
		},
	},
}
