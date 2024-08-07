return {
	"Exafunction/codeium.nvim",
	enabled = true,
	dependencies = {
		"hrsh7th/nvim-cmp",
	},
	event = "BufEnter",

	config = function()
		vim.g.codeium_disable_bindings = 1

		-- Change '<C-g>' here to any keycode you like.
		vim.keymap.set("i", "<C-g>", function()
			return vim.fn["codeium#Accept"]()
		end, { expr = true, silent = true })

		vim.keymap.set("i", "<C-,>", function()
			return vim.fn["codeium#CycleCompletions"](1)
		end, { expr = true, silent = true })

		vim.keymap.set("i", "<C-.>", function()
			return vim.fn["codeium#CycleCompletions"](-1)
		end, { expr = true, silent = true })

		vim.keymap.set("i", "<C-x>", function()
			return vim.fn["codeium#Clear"]()
		end, { expr = true, silent = true })

		require("codeium").setup({
      options = {
        enable_chat = true
      }
    })
	end,
}
