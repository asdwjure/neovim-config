return {
	'VonHeikemen/lsp-zero.nvim',
	branch = 'v4.x',
	dependencies = {
		-- LSP support
		'neovim/nvim-lspconfig',
		'williamboman/mason.nvim',
		'williamboman/mason-lspconfig.nvim',
		-- Autocompletion
		'hrsh7th/nvim-cmp',
		'hrsh7th/cmp-nvim-lsp',
		'L3MON4D3/LuaSnip',
	},
	config = function()
		local lsp_zero = require('lsp-zero')

		-- 1) Extend lspconfig (opt-in vs v2.x auto-config)
		lsp_zero.extend_lspconfig({
			capabilities = require('cmp_nvim_lsp').default_capabilities(),
			float_border = 'rounded',
			sign_text     = true,
			-- on_attach: set both the default + your custom keymaps
			lsp_attach = function(client, bufnr)
				lsp_zero.default_keymaps({ buffer = bufnr })        -- builtin bindings :contentReference[oaicite:0]{index=0}
				require('config.remap').lsp(bufnr)                  -- your extra LSP maps
			end,
		})

		-- 2) Mason for automatic server install
		require('mason').setup()
		require('mason-lspconfig').setup({
			ensure_installed = {'clangd', 'lua_ls' },
			handlers = {
				-- default handler for all servers
				function(server_name)
					require('lspconfig')[server_name].setup({})
				end,
			},
		})

		-- 3) nvim-cmp setup (lsp-zero no longer does this automatically)
		local cmp = require('cmp')
		cmp.setup({
			snippet = {
				expand = function(args)
					require('luasnip').lsp_expand(args.body)
				end,
			},
			mapping    = cmp.mapping.preset.insert({}),
			sources    = { { name = 'nvim_lsp' } },
			formatting = lsp_zero.cmp_format(),                 -- opt-in labels :contentReference[oaicite:1]{index=1}
		})
	end,
}
