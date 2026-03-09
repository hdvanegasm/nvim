# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Architecture

This is a Neovim configuration using [lazy.nvim](https://github.com/folke/lazy.nvim) as the plugin manager.

**Entry point:** `init.lua` → `lua/config/lazy.lua`

- `lua/config/lazy.lua` — bootstraps lazy.nvim, sets global options (`tabstop=4`, `shiftwidth=4`, leaders), and imports all plugins via `{ import = "plugins" }`
- `lua/plugins/` — each file returns a lazy.nvim plugin spec (a table with plugin name, dependencies, `opts`, `keys`, `config`, etc.)

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
| LSP | `nvim-lspconfig` (lua_ls, clangd, gopls, rust_analyzer, texlab, ruff, marksman, neocmake) |
| Formatting | `conform.nvim` (format-on-save; stylua for Lua, black+isort for Python, rustfmt for Rust, prettier for JS) |
| File tree | `neo-tree.nvim` |
| Fuzzy find | `telescope.nvim` |
| Diagnostics | `trouble.nvim` |
| File nav | `harpoon` (harpoon2 branch) |
| Git | `gitsigns.nvim`, `vim-fugitive` |
| Colorschemes | gruvbox (active), tokyonight, catppuccin (available) |
| Statusline | `lualine.nvim` (theme: tokyonight-night) |

## Key mappings (leader = Space)

| Key | Action |
|---|---|
| `<leader>ff` | Telescope find files |
| `<leader>fg` | Telescope live grep |
| `<leader>fe` | Toggle NeoTree |
| `<leader>e` | Focus NeoTree |
| `<leader>H` | Harpoon add file |
| `<leader>h` | Harpoon quick menu |
| `<leader>1-5` | Jump to harpoon file 1-5 |
| `<leader>cF` | Format buffer (conform) |
| `<leader>xx` | Toggle trouble diagnostics |
| `<leader>cs` | Toggle trouble symbols |
| `gd` / `gr` / `gI` | LSP go to definition/references/implementation |
| `K` | LSP hover |
| `<leader>ch` (C/C++) | ClangdSwitchSourceHeader |

## Adding a new plugin

Create `lua/plugins/<name>.lua` returning a lazy.nvim spec. It will be auto-imported. No registration needed elsewhere.

## Switching colorscheme

The active colorscheme is set in `lua/plugins/gruvbox.lua` via `vim.cmd([[colorscheme gruvbox]])`. To switch, disable that `config` block and set the colorscheme in the desired theme's plugin file. Lualine theme is set separately in `lua/plugins/lualine.lua`.
