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
	{
		"folke/flash.nvim", -- Better movements
		event = "VeryLazy",
		opts = {},
		keys = { {
			"r",
			mode = { "n", "x", "o" },
			function()
				require("flash").jump()
			end,
		} },
	},
	{ "tpope/vim-repeat" },
	-- Git stuffz
	{ "tpope/vim-fugitive" }, -- Git commands
	{ "tpope/vim-rhubarb" }, -- Fugitive github support
	{ "kdheepak/lazygit.nvim" }, -- LazyGit integration
	-- Visual
	{ "Makaze/AnsiEsc" }, -- Attempt to render ansi escape codes correctly
	{ "xiyaowong/transparent.nvim" }, -- Pretty transparency
	{ "winston0410/range-highlight.nvim" }, -- Highlight ranges in nvim commands
	-- Markdown
	{
		"OXY2DEV/markview.nvim", -- Markdown support
		lazy = false,
		opts = {
			experimental = {
				check_rtp_message = false,
			},
			markdown = {
				headings = { shift_width = 0 }, -- Don't shift headings
				list_items = {
					marker_minus = {
						text = "─",
					},
				},
			},
		},
	},
	{
		"obsidian-nvim/obsidian.nvim", -- Obsidian support
		dependencies = { "nvim-lua/plenary.nvim", "hrsh7th/nvim-cmp", "nvim-telescope/telescope.nvim" },
		opts = {
			workspaces = {
				{
					path = "~/notes",
				},
			},
			new_notes_location = "current_dir", -- Always make notes in current dir
			completion = { nvim_cmp = true }, -- Completions
			picker = { name = "telescope.nvim" }, -- Picker
			note_id_func = function(title) -- Note ID = Name of note
				if title ~= nil then
					return title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
				else
					return string.char(math.random(65, 90))
				end
			end,
			legacy_commands = false,
		},
	},
	{ "jbyuki/venn.nvim", lazy = false, keys = { { "\\", ":VBox<CR>", mode = "v" } } }, -- Diagram drawing
}
