-- Syntax for `mpc` files: Python-like, but not Python.
--
-- The filetype is registered as its own (`mpc`, see lua/config/lazy.lua) so that
-- nothing keyed on `python` — LSP (basedpyright/ruff), conform (isort/black),
-- Tree-sitter — ever attaches to these buffers. Highlighting is the one thing
-- borrowed: when the filetype is set, Vim's Syntax autocmd runs `set syntax=mpc`,
-- which sources this file, which in turn sources Python's regex syntax rules.
if vim.b.current_syntax then
	return
end

vim.cmd("runtime! syntax/python.vim")

-- python.vim leaves b:current_syntax = "python"; correct it so the buffer still
-- identifies as mpc (and so this guard works on a re-entry).
vim.b.current_syntax = "mpc"
