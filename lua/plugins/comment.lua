return {
    'numToStr/Comment.nvim',
    opts = {
        -- add any options here
    },
	config = function (_, opts)
		require("Comment").setup(opts)
	end
}

