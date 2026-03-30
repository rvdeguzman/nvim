local now = Config.now
local later = Config.later

now(function()
	require("mini.basics").setup({
		options = { basic = false, extra_ui = false, win_borders = "bold" },
		mappings = { windows = true, move_with_alt = true },
		autocommands = { basic = true },
		silent = true,
	})
end)

now(function()
	require("mini.icons").setup()
	MiniIcons.mock_nvim_web_devicons()
end)

later(function()
	require("mini.ai").setup({ n_lines = 500 })
end)

later(function()
	require("mini.bracketed").setup()
end)

later(function()
	require("mini.bufremove").setup()
end)

later(function()
	local clue = require("mini.clue")
	local clues = {}

	vim.list_extend(clues, clue.gen_clues.builtin_completion())
	vim.list_extend(clues, clue.gen_clues.g())
	vim.list_extend(clues, clue.gen_clues.marks())
	vim.list_extend(clues, clue.gen_clues.registers())
	vim.list_extend(clues, clue.gen_clues.windows())
	vim.list_extend(clues, clue.gen_clues.z())

	clue.setup({
		triggers = {
			{ mode = "n", keys = "<Leader>" },
			{ mode = "x", keys = "<Leader>" },
			{ mode = "n", keys = "[" },
			{ mode = "n", keys = "]" },
			{ mode = "n", keys = "g" },
			{ mode = "x", keys = "g" },
			{ mode = "n", keys = "z" },
			{ mode = "x", keys = "z" },
		},
		clues = clues,
		window = {
			delay = 250,
			config = function()
				local width = 42

				return {
					anchor = "NW",
					width = width,
					row = math.floor(0.5 * (vim.o.lines - 12)),
					col = math.floor(0.5 * (vim.o.columns - width)),
				}
			end,
		},
	})
end)

later(function()
	require("mini.cursorword").setup()
end)

later(function()
	require("mini.files").setup()
end)

later(function()
	local indentscope = require("mini.indentscope")

	indentscope.setup({
		symbol = "│",
		options = { try_as_border = true },
		draw = {
			animation = indentscope.gen_animation.none(),
		},
	})
end)

later(function()
	require("mini.pairs").setup()
end)

later(function()
	local pick = require("mini.pick")

	pick.setup({
		window = {
			config = function()
				local height = math.floor(0.62 * vim.o.lines)
				local width = math.floor(0.62 * vim.o.columns)

				return {
					anchor = "NW",
					height = height,
					width = width,
					row = math.floor(0.5 * (vim.o.lines - height)),
					col = math.floor(0.5 * (vim.o.columns - width)),
				}
			end,
		},
	})
end)

later(function()
	require("mini.sessions").setup()
end)

later(function()
	require("mini.surround").setup()
end)

later(function()
	require("mini.trailspace").setup()
end)

later(function()
	require("mini.visits").setup()
end)
