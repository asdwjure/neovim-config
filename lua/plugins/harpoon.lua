return {
	'ThePrimeagen/harpoon',
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		require('harpoon').setup({
			global_settings = {
				-- save harpoon file list when you add/change a mark
				save_on_change = true,
				-- don't save every time you toggle the UI
				save_on_toggle = false,
			},
		})

		-- wire up your keybindings
		require('config.remap').harpoon()
	end,
}

