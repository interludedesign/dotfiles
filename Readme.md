# Chris Swann Dotfiles

## Alacritty
Terminal emulator configuration is located at `~/.config/alacritty/alacritty.toml`. Currently using JetBrainsMono Nerd Font.

## Brew
There is a Brewfile for personal and work, which are symlinked to $HOME/Brewfile. Run
`brew bundle list` from anywhere. To install a package, add it to the respective Brewfile then
`brew bundle [install]`. Use `brew bundle dump` to build a new Brewfile

## Python
Using pyenv to manage python installations, a bit like rbenv. Use `pyenv install <version>` and 
`pyenv global <version>`

## Personal vs Work
When running `make personal`, stows anything in /personal to the root directory. So for example the
`Brewfile` will be symlinked to ~/Brewfile. If any config needs to be in personal vs work, place
in the appropriate directory.

## Snippets - luasnip
Snippets are added from rafamadriz/friendly-snippets
`<leader>fl` to list snippets (`:Telescope luasnip`)
`<Ctrl-L>` Jump forward
`<Ctrl-J>` Jump backward


## Completion - nvim-cmp
Sources for completion are also installed via plugins, of which there are several
`:help ins-completion` for vim completion keymaps

## LSP
