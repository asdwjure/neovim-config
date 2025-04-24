return {
	'nvim-telescope/telescope.nvim', tag = '0.1.8',
	-- or                              , branch = '0.1.x',
	dependencies = { 'nvim-lua/plenary.nvim' },
	config = function()
		-- Telescope defaults – tweak as desired
		require('telescope').setup {
			defaults = {
				prompt_prefix = '🔍 ',
				layout_config = {
					width = 0.85,
					preview_width = 0.5,
				},
				sorting_strategy = 'ascending',
			},
			pickers = {
				-- you can override picker-specific defaults here if you like
			},
			extensions = {
				-- extensions go here
			},
		}

		-- wire up your keybindings
		require('config.remap').telescope()
	end,
}
