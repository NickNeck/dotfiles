return {
	"andymass/vim-matchup",
	event = "BufReadPost",
	config = function()
		-- may set any options here
		vim.g.matchup_matchparen_offscreen = { method = "popup" }
	end,
}
