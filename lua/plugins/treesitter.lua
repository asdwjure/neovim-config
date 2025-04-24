return {
  'nvim-treesitter/nvim-treesitter',
  build = function()
    require('nvim-treesitter.install').update { with_sync = true }
  end,
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
  },
  config = function()
    require('nvim-treesitter.configs').setup {
      ensure_installed = {
        'c','lua','vim','vimdoc','query','elixir','heex','javascript','html',
      },
      sync_install = false,
      highlight = { enable = true },
      indent    = { enable = true },

      textobjects = {
        select = {
          enable    = true,     -- load the `locals` queries so @local.scope works if you ever need it
          lookahead = true,
          keymaps   = {
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["as"] = { query = "@local.scope", query_group = "locals", desc = "Select scope" },
          },
        },

        move = {
          enable    = true,
          set_jumps = true,     -- populate jumplist so <C-o> works

          goto_next_start = {
            ["]f"] = "@function.outer",  -- next function start
            ["]s"] = "@block.outer",     -- next block ({…}) start
          },
          goto_previous_start = {
            ["[f"] = "@function.outer",  -- prev function start
            ["[s"] = "@block.outer",     -- prev block start
          },

          goto_next_end = {
            ["]F"] = "@function.outer",
          },
          goto_previous_end = {
            ["[F"] = "@function.outer",
          },
        },
      },
    }
  end,
}
