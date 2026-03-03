# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Personal Neovim configuration using **lazy.nvim** as the plugin manager. All configuration is in Lua.

## Architecture

```
init.lua                    → requires('rv')
lua/rv/init.lua             → leader keys, netrw disable, global keymaps, loads opts + lazy_init
lua/rv/opts.lua             → vim options, diagnostics config, yank highlight autocmd
lua/rv/lazy_init.lua        → bootstraps lazy.nvim, imports all plugins from rv.plugins
lua/rv/plugins/             → one file per plugin (or plugin group), auto-discovered by lazy
after/ftplugin/             → filetype-specific overrides (e.g., typst.lua)
```

**Bootstrap flow:** `init.lua` → `rv/init.lua` (leader, netrw disable, global keymaps, opts, lazy) → `lazy_init.lua` (auto-install lazy, load all plugin specs from `rv.plugins`).

## Key Conventions

- **Leader:** `<Space>` (both leader and localleader)
- **Plugin configs:** Each plugin gets its own file in `lua/rv/plugins/`. Lazy.nvim auto-imports the directory.
- **Theme:** gruvbox.nvim (priority 1000, loads first)
- **File browser:** oil.nvim (`<leader>e`) replaces netrw
- **Fuzzy finder:** Telescope with fzf-native (`<leader><leader>` files, `<leader>,` grep, `<leader>.` recent)
- **Navigation:** flash.nvim (replaces f/F/t/T), harpoon (`<leader>1-9`), vim-tmux-navigator (`<C-hjkl>`)
- **Completion:** blink.cmp with LuaSnip snippets (triggers on InsertEnter)
- **LSP stack:** mason.nvim → mason-lspconfig → nvim-lspconfig. Servers: lua_ls, ts_ls, pyright, clangd, ruff, flutter-tools
- **Formatting:** conform.nvim (format-on-save via BufWritePre, 500ms timeout, LSP fallback). Formatters: stylua, prettier, dart format
- **Linting:** nvim-lint (runs on BufWritePost, linters_by_ft currently empty)
- **Git:** vim-fugitive + gitsigns.nvim (`<leader>h*` for hunk operations)
- **Copilot:** installed but disabled by default (`<leader>ct` to toggle)

## Global Keymaps (rv/init.lua)

These are set outside any plugin and apply everywhere:
- `<Esc>` → clear search highlights
- `<C-q>` → force quit all
- `<leader>wv/wh/wd` → vertical split / horizontal split / close window
- `<leader>y/p` → clipboard yank/paste (uses `"+`)

## Adding a New Plugin

Create `lua/rv/plugins/<name>.lua` returning a lazy.nvim plugin spec table. Lazy.nvim auto-discovers it. Use lazy-loading keys (`cmd`, `event`, `ft`, `keys`) where possible.

## Adding a New LSP Server

1. Add the server name to the `servers` table in `lua/rv/plugins/lsp.lua`
2. Add any server-specific settings in the same table
3. Mason will auto-install it; mason-lspconfig bridges to lspconfig

## Patterns to Follow

- Plugin specs must return a table (or list of tables) — imperative code like `require(...)` and `vim.cmd(...)` goes inside `config = function() ... end`, never at the top level of the spec
- LSP keymaps are buffer-local, set in the `LspAttach` autocmd in `lsp.lua`
- Gitsigns keymaps are buffer-local, set in its `on_attach` callback
- All LSP servers share base capabilities with extended completion support from blink.cmp
- Diagnostics use rounded borders, severity sort, and virtual text with `●` prefix
