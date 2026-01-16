-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information

return {
  {
    'stevearc/oil.nvim', -- File manager
    opts = {},
    -- dependencies = { { 'echasnovski/mini.icons', opts = {} } },
    lazy = false,
  },
  {
    'folke/flash.nvim', -- Better movements
    keys = { {
      'r',
      mode = { 'n', 'x', 'o' },
      function()
        require('flash').jump()
      end,
    } },
  },
  'xiyaowong/transparent.nvim', -- Pretty transparency
  'winston0410/range-highlight.nvim', -- Highlight ranges in nvim commands
}
