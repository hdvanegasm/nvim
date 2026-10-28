return {
	"nvim-mini/mini.bufremove",
	keys = {
		{
			"<leader>bd",
			function()
				local bufremove = require("mini.bufremove")
				if vim.bo.modified then
					local choice =
						vim.fn.confirm(("Save changes to %q?"):format(vim.fn.bufname()), "&Yes\n&No\n&Cancel")
					if choice == 1 then -- yes
						vim.cmd.write()
						bufremove.delete(0)
					elseif choice == 2 then -- no
						bufremove.delete(0, true)
					end
				else
					bufremove.delete(0)
				end
			end,
			desc = "Close buffer (keep window)",
		},
		{
			"<leader>bD",
			function()
				require("mini.bufremove").delete(0, true)
			end,
			desc = "Close buffer (force)",
		},
	},
	opts = {},
}
