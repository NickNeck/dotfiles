return {
	"hrsh7th/nvim-cmp",
	enabled = true,
	event = "InsertEnter",
	dependencies = {
		"hrsh7th/cmp-buffer", -- source for text in buffer
		"hrsh7th/cmp-path", -- source for file system paths
		{
			"L3MON4D3/LuaSnip",
			-- follow latest release.
			version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
			-- install jsregexp (optional!).
			build = "make install_jsregexp",
		},
		"saadparwaiz1/cmp_luasnip", -- for autocompletion
		"rafamadriz/friendly-snippets", -- useful snippets
		"onsails/lspkind.nvim", -- vs-code like pictograms
	},
	config = function()
		local cmp = require("cmp")

		local luasnip = require("luasnip")

		local lspkind = require("lspkind")

		-- loads vscode style snippets from installed plugins (e.g. friendly-snippets)
		require("luasnip.loaders.from_vscode").lazy_load()

		cmp.setup({
			completion = {
				completeopt = "menu,menuone,preview,noselect",
			},
			snippet = { -- configure how nvim-cmp interacts with snippet engine
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			mapping = cmp.mapping.preset.insert({
				["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
				["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
				["<C-e>"] = cmp.mapping.abort(), -- close completion window
				["<CR>"] = cmp.mapping.confirm({ select = false }),
			}),
			-- sources for autocompletion
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "codeium" }, -- file system paths
				{ name = "luasnip" }, -- snippets
				{ name = "buffer" }, -- text within current buffer
				{ name = "path" }, -- file system paths
			}),

			-- configure lspkind for vs-code like pictograms in completion menu
			-- formatting = {
			-- 	format = lspkind.cmp_format({
			-- 		maxwidth = 60,
			-- 		ellipsis_char = "…",
			-- 	}),
			-- },
			formatting = {
				format = function(entry, vim_item)
					-- if you have lspkind installed, you can use it like
					-- in the following line:
					vim_item.kind = require("lspkind").symbolic(vim_item.kind, { mode = "symbol_text" })

					-- if entry.source.name ~= nil then
					-- 	vim_item.menu = source_mapping[entry.source.name]
					-- end
          print(entry.source.name)

					if entry.source.name == "codeium" then
						local detail = (entry.completion_item.data or {}).detail
						vim_item.kind = " Codeium"
						if detail and detail:find(".*%%.*") then
							vim_item.kind = vim_item.kind .. " " .. detail
						end

						if (entry.completion_item.data or {}).multiline then
							vim_item.kind = vim_item.kind .. " " .. "[ML]"
						end
					end

					local maxwidth = 80
					local ellipsis_char = "…"

					vim_item.abbr = string.sub(vim_item.abbr, 1, maxwidth)

					return vim_item
				end,
			},
		})
	end,
}
