return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 500
	end,
	keys = {
		{ "<leader>w", "<cmd>WhichKey <cr>", desc = "WhichKey" },
	},
	opts = {
		plugins = {
			spelling = true,
			presets = {
				operators = false, -- adds help for operators like d, y, ...
				motions = false, -- adds help for motions
				text_objects = true, -- help for text objects triggered after entering an operator
				windows = true, -- default bindings on <c-w>
				nav = true, -- misc bindings to work with windows
				z = true, -- bindings for folds, spelling and others prefixed with z
				g = true, -- bindings for prefixed with g
			},
		},
		defaults = {
			mode = { "n", "v" },
			-- ["d"] = { name = "which_key_ignore" },
      { "g", group= "goto" },
      { "]", group= "next" },
      { "[", group= "prev" },
      { "s", group= "leap to" },
      { "<leader>f", group= "file/find" },
      { "<leader>c", group= "clear" },
      { "<leader>e", group= "explorer" },
      { "<leader>h", group= "hunks" },
      { "<leader>l", group= "lazy" },
      { "<leader>s", group= "split" },
      { "<leader>x", group= "diagnostics/quickfix" },
		},
	},
	config = function(_, opts)
		local wk = require("which-key")
		wk.setup(opts)
		wk.add(opts.defaults)
	end,
}
