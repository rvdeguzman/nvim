# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Personal Neovim configuration using **lazy.nvim** as the plugin manager. All configuration is in Lua.

## Architecture

```
init.lua                    → requires('rv')
lua/rv/init.lua             → sets leader keys, disables netrw, loads opts + lazy_init
lua/rv/opts.lua             → vim options, diagnostics config, yank highlight autocmd
lua/rv/lazy_init.lua        → bootstraps lazy.nvim, imports all plugins from rv.plugins
lua/rv/plugins/             → one file per plugin (or plugin group)
after/ftplugin/             → filetype-specific overrides (e.g., typst.lua)
```

**Bootstrap flow:** `init.lua` → `rv/init.lua` (leader, netrw disable, opts, lazy) → `lazy_init.lua` (auto-install lazy, load all plugin specs from `rv.plugins`).

## Key Conventions

- **Leader:** `<Space>` (both leader and localleader)
- **Plugin configs:** Each plugin gets its own file in `lua/rv/plugins/`. Lazy.nvim auto-imports the directory.
- **LSP stack:** mason.nvim → mason-lspconfig → nvim-lspconfig. Servers configured: lua_ls, ts_ls, pyright, clangd, ruff, flutter-tools.
- **Completion:** blink.cmp with LuaSnip snippets
- **Formatting:** conform.nvim (format-on-save via BufWritePre, 500ms timeout, LSP fallback). Formatters: stylua (Lua), prettier (JS/TS), dart format.
- **Linting:** nvim-lint (runs on BufWritePost)
- **Theme:** miasma with transparent background (Normal, NormalFloat, NormalNC, SignColumn cleared)
- **File browser:** oil.nvim (replaces netrw)
- **Fuzzy finder:** Telescope with fzf-native backend

## Adding a New Plugin

Create `lua/rv/plugins/<name>.lua` returning a lazy.nvim plugin spec table. Lazy.nvim auto-discovers it. Use lazy-loading keys (`cmd`, `event`, `ft`, `keys`) where possible.

## Adding a New LSP Server

1. Add the server name to the `servers` table in `lua/rv/plugins/lsp.lua`
2. Add any server-specific settings in the same table
3. Mason will auto-install it; mason-lspconfig bridges to lspconfig

## Disabled Built-in Plugins

gzip, matchit, matchparen, tarPlugin, tohtml, tutor, zipPlugin (configured in lazy_init.lua performance section).

## Git-Ignored Artifacts

tags, test.sh, .luarc.json, spell/, lazy-lock.json, claude/ directory
