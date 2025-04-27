return {
    'p00f/clangd_extensions.nvim',
    dependencies = { 'neovim/nvim-lspconfig' },
    ft = { 'c', 'cpp', 'objc', 'objcpp' },
    config = function()
        local clangd_ext = require('clangd_extensions')
        local lspconfig  = require('lspconfig')
        local util       = require('lspconfig.util')

        clangd_ext.setup({
            -- pass through your existing clangd command and root detection
            server = {
                cmd = {
                    'clangd',
                    '--background-index',
                    '--clang-tidy',
                    '--completion-style=detailed',
                    '--compile-commands-dir=' .. vim.fn.getcwd(),
                    '--fallback-style={"BasedOnStyle":"LLVM","IndentWidth":4,"TabWidth":4,"UseTab":"Never"}',
                },
                root_dir = util.root_pattern('compile_commands.json', 'Makefile', '.git'),
                offset_encodings = { 'utf-8' },
                capabilities      = require('cmp_nvim_lsp').default_capabilities(),
                on_attach         = function(client, bufnr)
                    -- you can still call your existing on_attach logic:
                    require('config.remap').lsp(bufnr)
                    -- plus any clangd-extensions keymaps:
                    local map = vim.keymap.set
                    local opts = { buffer = bufnr, silent = true, noremap = true }

                    -- Example extension mappings:
                    map('n', '<leader>ci', function() clangd_ext.inlay_hints.toggle() end,
                        { desc = 'Toggle Inlay Hints' })
                    map('n', '<leader>cs', function() clangd_ext.status() end,
                        { desc = 'Show clangd status' })
                end,
            },
            extensions = {
                -- inlay hints options (see docs for more)
                inlay_hints = {
                    auto = true,         -- show on buffer open and on edits
                    only_current_line = false,
                },
                ast = {
                    role_icons = {
                        type = '🅣',
                        declaration = '🔖',
                        expression = '📦',
                        statement  = '📜',
                        ['']       = '🔹',
                    },
                    -- depth to render in the AST panel
                    depth = 4,
                    -- whether to highlight the AST nodes in the editor
                    highlight = true,
                },
                memory_usage = {
                    border = 'rounded',
                },
            },
        })
    end,
}

