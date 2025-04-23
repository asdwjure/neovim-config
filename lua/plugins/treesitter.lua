return {
	'nvim-treesitter/nvim-treesitter',
	-- update all installed parsers synchronously after install
	build = function()
		require('nvim-treesitter.install').update { with_sync = true }
	end,
	config = function()
		require('nvim-treesitter.configs').setup {
			ensure_installed = {
				'c',
				'cpp',
				'python',
				'lua',
				'vim',
				'vimdoc',
				'yaml',
				'markdown',
				'markdown_inline',
			},
			sync_install = false,
			highlight = { enable = true },
			indent    = { enable = true },
		}
	end,
}
