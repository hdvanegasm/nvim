return {
	"nvim-lualine/lualine.nvim",
	opts = {
		options = {
			theme = "auto",
			globalstatus = true,
			section_separators = { left = "", right = "" },
			component_separators = { left = "│", right = "│" },
		},
		sections = {
			lualine_b = {
				"branch",
				{ "diff", symbols = { added = " ", modified = " ", removed = " " } },
				{ "diagnostics", symbols = { error = " ", warn = " ", info = " ", hint = " " } },
			},
			lualine_c = {
				{ "filename", path = 1, symbols = { modified = " ●", readonly = " " } },
			},
			lualine_x = {
				{
					function()
						local names = {}
						for _, c in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
							table.insert(names, c.name)
						end
						return table.concat(names, " ")
					end,
					icon = "",
				},
				"filetype",
			},
		},
		extensions = { "neo-tree", "trouble", "nvim-dap-ui", "fugitive", "lazy", "quickfix" },
	},
}
