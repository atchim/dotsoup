local M = {}

M.config = function()
  require'nvim-tree'.setup{
    diagnostics = {enable = true},
    update_to_buf_dir = {enable = false},
    view = {mappings = {list = {
      {key = '-', action = ''},
      {key = '.', action = 'toggle_dotfiles'},
      {key = '<', action = 'prev_sibling'},
      {key = {'<2-LeftMouse>', '<CR>', 'o'}, action = 'edit_no_picker'},
      {key = {'<2-RightMouse>', '<C-]>'}, action = 'cd'},
      {key = '<BS>', action = ''},
      {key = '<C-L>', action = 'refresh'},
      {key = '<C-e>', action = ''},
      {key = '<C-k>', action = ''},
      {key = '<C-r>', action = ''},
      {key = '<C-t>', action = ''},
      {key = '<C-v>', action = ''},
      {key = '<C-x>', action = ''},
      {key = '<Tab>', action = 'preview'},
      {key = '>', action = 'next_sibling'},
      {key = 'D', action = 'trash'},
      {key = 'H', action = ''},
      {key = 'I', action = ''},
      {key = 'J', action = ''},
      {key = 'K', action = 'show_file_info'},
      {key = 'O', action = 'edit'},
      {key = 'P', action = ''},
      {key = 'R', action = 'full_rename'},
      {key = 'S', action = ''},
      {key = 'W', action = ''},
      {key = 'Y', action = 'copy_path'},
      {key = '[[', action = 'parent_node'},
      {key = '[c', action = ''},
      {key = '[g', action = 'prev_git_item'},
      {key = ']c', action = ''},
      {key = ']g', action = 'next_git_item'},
      {key = 'a', action = 'create'},
      {key = 'c', action = 'copy'},
      {key = 'd', action = 'remove'},
      {key = 'g.', action = 'toggle_ignored'},
      {key = 'g<', action = 'first_sibling'},
      {key = 'g>', action = 'last_sibling'},
      {key = 'g?', action = 'toggle_help'},
      {key = 'gf', action = 'edit_in_place'},
      {key = 'gk', action = 'show_file_info'},
      {key = 'go', action = 'system_open'},
      {key = 'gt', action = 'tabnew'},
      {key = 'gy', action = ''},
      {key = 'i', action = 'split'},
      {key = 'p', action = 'paste'},
      {key = 'q', action = 'close'},
      {key = 'r', action = 'rename'},
      {key = 's', action = 'vsplit'},
      {key = 'x', action = 'cut'},
      {key = 'y', action = ''},
      {key = 'y/', action = 'copy_absolute_path'},
      {key = 'yy', action = 'copy_name'},
      {key = 'zM', action = 'collapse_all'},
      {key = 'zc', action = 'close_node'},
    }}},
  }

  require'sopa.tree'.hi()

  -- TODO: Maybe register default mappings.
  require'which-key'.register({
    ['<Space>'] = {
      name = 'Tree',
      ['<Space>'] = {'<Cmd>NvimTreeToggle<CR>', 'Toggle Tree'},
      ['<CR>'] = {'<Cmd>NvimTreeFocus<CR>', 'Focus Tree'},
    },
  }, {prefix = '<Leader>'})
end

return M
