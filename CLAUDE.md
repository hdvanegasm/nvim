# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Architecture

This is a Neovim configuration using [lazy.nvim](https://github.com/folke/lazy.nvim) as the plugin manager.

**Entry point:** `init.lua` → `lua/config/lazy.lua`

- `lua/config/lazy.lua` — bootstraps lazy.nvim, sets global options (`tabstop=4`, `shiftwidth=4`, leaders), and imports all plugins via `{ import = "plugins" }`
- `lua/plugins/` — each file returns a lazy.nvim plugin spec (a table with plugin name, dependencies, `opts`, `keys`, `config`, etc.)
- `after/ftplugin/tex.lua` — buffer-local prose settings for LaTeX (spell, soft wrap, display-line `j`/`k`)

Icons come from `mini.icons`, which mocks `nvim-web-devicons` via `package.preload` (see `lua/plugins/nvim-dev-web-icons.lua`). Do **not** add `nvim-tree/nvim-web-devicons` as a dependency — the mock covers any plugin that requires it.

## Plugin conventions

Each plugin file in `lua/plugins/` follows the lazy.nvim spec pattern:

```lua
return {
  "author/plugin-name",
  lazy = true,         -- load on demand
  cmd = "...",         -- load on command
  keys = { ... },      -- load on keymap
  opts = { ... },      -- passed to setup()
  config = function(_, opts) ... end,  -- custom setup logic
}
```

When `opts` is sufficient, skip `config`. Use `config` only when custom setup logic is needed beyond passing opts.

## Key plugin stack

| Category | Plugin |
|---|---|
| Completion | `blink.cmp` (blink.cmp v1, with LSP/path/snippets/buffer sources) |
| LSP | `nvim-lspconfig` (lua_ls, clangd, gopls, rust_analyzer, texlab, ruff, basedpyright, marksman, neocmake, …); keymaps are buffer-local via an `LspAttach` autocmd |
| Formatting | `conform.nvim` (format-on-save except tex/bib; stylua for Lua, black+isort for Python, rustfmt for Rust, prettier for JS, latexindent for LaTeX) |
| Debugging | `nvim-dap` + `nvim-dap-ui` (lldb-dap for C/C++/Rust, debugpy for Python, delve for Go) |
| File tree | `neo-tree.nvim` |
| Fuzzy find | `telescope.nvim` (fzf-native) |
| Diagnostics | `trouble.nvim` |
| File nav | `harpoon` (harpoon2 branch) |
| Motion | `flash.nvim` (`s`/`S` jump) |
| Editing | `mini.pairs` (autopairs), `mini.surround` (`gz` prefix) |
| Git | `gitsigns.nvim` (hunks), `vim-fugitive`, `diffview.nvim` |
| LaTeX | `vimtex` (latexmk build, zathura view) + texlab LSP (chktex lint) + latexindent via conform (manual `<leader>cf` only) |
| Markdown | `render-markdown.nvim`, `nabla.nvim` (math preview) |
| Colorscheme | `ember` (the only installed theme) |
| Statusline | `lualine.nvim` (theme: auto — follows colorscheme) |
| UI | `bufferline.nvim`, `fidget.nvim` (notifications, replaces `vim.notify`), `which-key.nvim`, `todo-comments.nvim`, `no-neck-pain.nvim` |

## Key mappings (leader = Space, localleader = `\`)

Which-key (`<leader>` and wait) shows the full list; this is the curated map.

| Key | Action |
|---|---|
| `<leader>ff` / `fg` / `fb` / `fh` | Telescope: files / live grep / buffers / help |
| `<leader>fe` / `<leader>e` | Toggle / focus NeoTree |
| `<leader>ha` / `hh` / `1-5` | Harpoon: pin file / menu / jump to pin 1-5 |
| `<leader>cf` | Format buffer (conform) |
| `<leader>xx` / `cs` | Trouble: diagnostics / symbols outline |
| `<leader>uh` / `un` | Toggle inlay hints / No-Neck-Pain |
| `<leader>um` / `up` | Toggle / preview math rendering (nabla) |
| `gd` / `grr` / `gri` / `grt` / `gO` | LSP via telescope: definition / references / implementation / type def / symbols (buffer-local, on attach) |
| `grn` / `gra` / `K` | LSP rename / code action / hover (nvim 0.12 defaults, not remapped) |
| `<leader>ch` (C/C++) | Switch source/header (clangd, buffer-local) |
| `s` / `S` | Flash jump / treesitter select |
| `gza` / `gzd` / `gzr` | Surround add / delete / replace (mini.surround) |
| `af`/`if`, `ac`/`ic`, `aa`/`ia` | Textobjects: function / class / parameter |
| `]f` `[f` / `]c` `[c` / `]a` `[a` | Move to next/prev function / class / parameter |
| `]h` `[h`, `<leader>gs` / `gr` / `gp` / `gi` / `gt` | Git hunks: navigate, stage-toggle / reset / preview / inline preview / line-blame toggle (gitsigns) |
| `<leader>gg` / `gd` / `ge` | Fugitive summary / Diffview / git status tree |
| `<leader>d*` | Debug: `dc` continue, `db` breakpoint, `do`/`di`/`dO` step, `du` DAP UI |
| `<S-h>` / `<S-l>`, `[b` / `]b` | Cycle buffers (bufferline) |
| `\ll` / `\lv` / `\le` (LaTeX) | Vimtex: compile watch / view PDF / errors |

## Adding a new plugin

Create `lua/plugins/<name>.lua` returning a lazy.nvim spec. It will be auto-imported. No registration needed elsewhere.

## Colorscheme

`ember` is the only installed theme, applied in `lua/plugins/ember.lua` (`lazy = false`, `priority = 1000`, `vim.cmd("colorscheme ember")`). Lualine follows it via `theme = "auto"`. To change themes, replace `ember.lua` with the new theme's spec and move the `colorscheme` call there. Note: `flash.lua` hardcodes the `FlashLabel` highlight (ember does not define it).
