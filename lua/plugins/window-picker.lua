return {
  's1n7ax/nvim-window-picker',
  name    = 'window-picker',
  version = '2.*',
  -- load at startup so our remap() can wire in right away
  config = function()
    require('window-picker').setup({
      -- you can pass any of the options documented here:
      -- https://github.com/s1n7ax/nvim-window-picker#configuration :contentReference[oaicite:0]{index=0}
      hint = "floating-big-letter",
      autoselect_one = true,
      include_current_win = false,
      selection_chars = 'FJDKSLA;CMRUEIWOQP',
      filter_rules = {
        -- filter out these filetypes / buftypes from the picker
        bo = {
          filetype = { 'neo-tree', 'NvimTree', 'help' },
          buftype   = { 'terminal' },
        },
      },
    })
    -- now wire up your mapping
    require('config.remap').window_picker()
  end,
}

