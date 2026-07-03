-- Prose-friendly settings for LaTeX buffers
vim.opt_local.spell = true
vim.opt_local.spelllang = { "en" } -- add "es" here to also spell-check Spanish (nvim offers to download the dictionary)

-- Soft-wrap long lines at word boundaries instead of hard-breaking mid-word
vim.opt_local.wrap = true
vim.opt_local.linebreak = true
vim.opt_local.breakindent = true

-- Navigate wrapped lines visually
vim.keymap.set({ "n", "x" }, "j", "gj", { buffer = true, desc = "Down (display line)" })
vim.keymap.set({ "n", "x" }, "k", "gk", { buffer = true, desc = "Up (display line)" })
