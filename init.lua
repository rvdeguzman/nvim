vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.loader.enable()

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.have_nerd_font = true

_G.Config = {}

vim.pack.add({ 'https://github.com/nvim-mini/mini.nvim' }, {
  confirm = false,
  load = true,
})

local function handle_error(tag, err)
  vim.schedule(function()
    vim.notify(('%s: %s'):format(tag, err), vim.log.levels.ERROR)
  end)
end

Config.now = function(f)
  local ok, err = xpcall(f, debug.traceback)
  if not ok then
    handle_error('Config.now', err)
  end
end

Config.later = function(f)
  vim.schedule(function()
    local ok, err = xpcall(f, debug.traceback)
    if not ok then
      handle_error('Config.later', err)
    end
  end)
end

Config.now_if_args = vim.fn.argc(-1) > 0 and Config.now or Config.later

local group = vim.api.nvim_create_augroup('config', { clear = true })

Config.new_autocmd = function(events, pattern, callback, desc)
  vim.api.nvim_create_autocmd(events, {
    group = group,
    pattern = pattern,
    callback = callback,
    desc = desc,
  })
end

Config.on_packchanged = function(plugin_name, kinds, callback, desc)
  Config.new_autocmd('PackChanged', '*', function(ev)
    local name = ev.data.spec.name
    local kind = ev.data.kind

    if name ~= plugin_name or not vim.tbl_contains(kinds, kind) then
      return
    end

    if not ev.data.active then
      vim.cmd.packadd(plugin_name)
    end

    callback(ev)
  end, desc)
end
