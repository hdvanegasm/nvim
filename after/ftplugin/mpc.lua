-- mpc comments are Python's `#` comments. Highlighting them already comes from
-- Python's syntax rules (see syntax/mpc.lua); these two options are what the
-- *editing* commands read: `commentstring` drives `gcc`/`gc{motion}`, and
-- `comments` drives comment continuation under `formatoptions`. Values copied
-- from $VIMRUNTIME/ftplugin/python.vim, which mpc buffers never source.
vim.bo.commentstring = "# %s"
vim.bo.comments = "b:#,fb:-"
