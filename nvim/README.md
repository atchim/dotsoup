# Dotfiles for Neovim

## The Zen of Soup

- Only override a default mapping if:
  - There is other mappings which performs the same operation.
    - E.G.: `<C-H>`, `<BS>`, `<Left>` etc.
  - The functionality to be mapped would work similar to the original.
    - E.G.: Remapping tag functionalities with ones from LSP.
  - It has no practical use.
    - E.G.: Remapping tag functionalities which is not used.
