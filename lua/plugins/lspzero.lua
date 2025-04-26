return {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v4.x',
    dependencies = {
        -- core LSP & Mason
        'neovim/nvim-lspconfig',
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        -- Completion
        'hrsh7th/nvim-cmp',
        'hrsh7th/cmp-nvim-lsp',
        'L3MON4D3/LuaSnip',
        -- 'saadparwaiz1/cmp_luasnip', -- bridge cmp <-> luasnip
    },
    config = function()
        local lsp_zero = require('lsp-zero')
        local util     = require('lspconfig.util')

        -- 1) Base LSP settings and on_attach
        lsp_zero.extend_lspconfig({
            capabilities = require('cmp_nvim_lsp').default_capabilities(),
            float_border = 'rounded',
            sign_text    = true,
            lsp_attach   = function(client, bufnr)
                -- your keymaps (definition, hover, etc)
                lsp_zero.default_keymaps({ buffer = bufnr })
                require('config.remap').lsp(bufnr)
            end,
        })

        -- 2) Mason + Mason-LSPConfig
        require('mason').setup()
        require('mason-lspconfig').setup({
            ensure_installed = { 'clangd', 'lua_ls','pyright' },
            handlers = {
                -- clangd setup for big C/C++ codebases (Yocto etc)
                ['clangd'] = function()
                    require('lspconfig').clangd.setup({
                        cmd = {
                            'clangd',
                            '--background-index',
                            '--clang-tidy',
                            '--completion-style=detailed',
                            -- if you have a Yocto cross‐compiler, point query-driver at it:
                            -- '--query-driver=/path/to/yocto/sysroots/.../bin/*-gcc'
                        },
                        filetypes = { 'c', 'cpp', 'objc', 'objcpp' },
                        root_dir = util.root_pattern('compile_commands.json', 'Makefile', '.git'),
                        -- force a single offset_encoding to avoid warnings
                        -- offset_encodings = { 'utf-16' },
                    })
                end,

                -- Python LSP
                ['pyright'] = function()
                    require('lspconfig').pyright.setup({
                        root_dir = util.root_pattern('pyproject.toml', 'setup.py', '.git'),
                    })
                end,

                -- fallback for any other server (if you add more later)
                function(server_name)
                    require('lspconfig')[server_name].setup({})
                end,
            },
        })

        -- 3) nvim-cmp (completion)
        local cmp = require('cmp')
        local luasnip = require('luasnip')

        -- lazy-load any vscode-style snippets you have installed
        require('luasnip.loaders.from_vscode').lazy_load()

        cmp.setup({
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert({
                -- use <Tab> and <S-Tab> to navigate snippet placeholders
                ['<Tab>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif luasnip.expand_or_jumpable() then
                        luasnip.expand_or_jump()
                    else
                        fallback()
                    end
                end, { 'i', 's' }),

                ['<S-Tab>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { 'i', 's' }),

                -- Press <CR> to confirm LSP selection but <TAB> also does this so we dont need it for now
                ["<CR>"] = cmp.mapping.confirm({ select = false }),
            }),
            sources = {
                { name = 'nvim_lsp' },
                { name = 'luasnip' },
                { name = 'buffer' },
                { name = 'path' },
            },
            formatting = lsp_zero.cmp_format(),
            experimental = {
                ghost_text = { hl_group = "Comment" },
            },
        })
    end,
}
