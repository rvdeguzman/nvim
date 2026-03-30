# CLAUDE.md

Neovim 0.12 config built around native features:

- `vim.pack` for plugin management
- native `vim.lsp.config()` / `vim.lsp.enable()` for LSP
- a mini-first UI and workflow

## Layout

```
init.lua
plugin/10_options.lua
plugin/20_keymaps.lua
plugin/30_mini.lua
plugin/40_plugins.lua
plugin/50_lsp.lua
lsp/*.lua
```

## Conventions

- Prefer native Neovim 0.12 APIs over compatibility layers.
- Prefer `mini.nvim` modules before adding a new plugin.
- Keep startup explicit: `Config.now()` for immediate work, `Config.later()` for deferred work.
- Keep per-server LSP config in `lsp/<server>.lua`.
- Use `PackChanged` hooks for plugin post-install/update actions.

## Current Non-mini Plugins

- `gruvbox.nvim`
- `gitsigns.nvim`
- `vim-fugitive`
- `vim-tmux-navigator`
- `conform.nvim`
- `nvim-treesitter`
- `codecompanion.nvim`
- `copilot.vim`
- `ThePrimeagen/99`
