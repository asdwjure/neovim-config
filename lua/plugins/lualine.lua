return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },  -- optional, for icons
  config = function()
    require('lualine').setup({
      options = {
        theme             = 'auto',    -- pick up your colorscheme
        section_separators= '',
        component_separators= '',
      },
      sections = {
        -- left-side
        lualine_a = { 'mode' },        -- shows NORMAL/INSERT/… 
        lualine_b = { 'branch' },      -- current Git branch
        lualine_c = { {'filename', path = 1} },    -- file path
        -- right-side
        lualine_x = { 'encoding', 'fileformat', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' },
      },
    })
  end,
}
