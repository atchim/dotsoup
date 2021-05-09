local function config()
  require 'which-key'.register(
    {
      ['/'] = {
        name = 'Find',

        ['/'] = {
          '<Cmd>lua require "telescope.builtin".find_files()<CR>',
          'Files',
        },

        b = {
          '<Cmd>lua require "telescope.builtin".buffers()<CR>',
          'Buffers',
        },

        g = {
          '<Cmd>lua require "telescope.builtin".live_grep()<CR>',
          'Live grep',
        },

        h = {
          '<Cmd>lua require "telescope.builtin".help_tags()<CR>',
          'Help tags',
        },
      }
    },

    { prefix = '<Leader>' }
  )
end

return { config = config }
