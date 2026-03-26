local theme_file = vim.fn.expand("~/.config/omarchy/current/theme/neovim.lua")
if vim.fn.filereadable(theme_file) == 1 then
    local specs = dofile(theme_file)
    local result = {}
    for _, spec in ipairs(specs) do
        if type(spec) == "table" and spec[1] ~= "LazyVim/LazyVim" then
            spec.lazy = false
            spec.priority = 1000
            table.insert(result, spec)
        elseif type(spec) == "table" and spec[1] == "LazyVim/LazyVim" then
            local cs = spec.opts and spec.opts.colorscheme
            if cs and #result > 0 then
                result[#result].config = function()
                    vim.cmd("colorscheme " .. cs)
                end
            end
        end
    end
    return result
end

return {
    "xero/miasma.nvim",
    lazy = false,
    priority = 1000,
    config = function()
        vim.cmd("colorscheme miasma")
    end,
}
