-- Prose-friendly settings for LaTeX buffers
vim.opt_local.spell = true
vim.opt_local.spelllang = { "en" } -- add "es" here to also spell-check Spanish (nvim offers to download the dictionary)

-- VimTeX conceal: render \alpha->α, fractions, sub/superscripts, \left(...\right)
-- inline. conceallevel=2 shows the replacement glyph; concealcursor="" reveals
-- the raw source on whichever line the cursor sits on (in every mode) so what
-- you edit is never hidden. Tune per feature via g:vimtex_syntax_conceal, or set
-- conceallevel=0 to turn it all off.
vim.opt_local.conceallevel = 2
vim.opt_local.concealcursor = ""

-- Soft-wrap long lines at word boundaries instead of hard-breaking mid-word
vim.opt_local.wrap = true
vim.opt_local.linebreak = true
vim.opt_local.breakindent = true

-- Navigate wrapped lines visually; with a count, move over real lines so
-- 5j lands where the relative line numbers say it will
vim.keymap.set(
	{ "n", "x" },
	"j",
	"v:count == 0 ? 'gj' : 'j'",
	{ buffer = true, expr = true, desc = "Down (display line)" }
)
vim.keymap.set(
	{ "n", "x" },
	"k",
	"v:count == 0 ? 'gk' : 'k'",
	{ buffer = true, expr = true, desc = "Up (display line)" }
)
