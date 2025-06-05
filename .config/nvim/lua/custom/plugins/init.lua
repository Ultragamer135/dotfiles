-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
	{
		"stevearc/oil.nvim", -- File manager
		---@module 'oil'
		---@type oil.SetupOpts
		opts = {},
		-- Optional dependencies
		dependencies = { { "echasnovski/mini.icons", opts = {} } },
		-- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
		-- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
		lazy = false,
	},
	{ "ggandor/leap.nvim" }, -- Leap around file with R
	{ "tpope/vim-repeat" },
	{ "tpope/vim-fugitive" }, -- Git commands
	{ "tpope/vim-rhubarb" }, -- Fugitive github support
	{ "kdheepak/lazygit.nvim" }, -- LazyGit integration
	{ "Makaze/AnsiEsc" }, -- Attempt to render ansi escape codes correctly
	{ "xiyaowong/transparent.nvim" }, -- Pretty transparency
	{
		"winston0410/range-highlight.nvim", -- Highlight ranges in nvim commands
		event = { "CmdlineEnter" },
		opts = {},
	},
	{ "tidalcycles/vim-tidal" }, -- Yay music
	{ "Apeiros-46B/qalc.nvim" }, -- Yay calculator
}
