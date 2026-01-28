source $HOME/.zsh_profile

export NVM_DIR="$HOME/.nvm"
if [ -s "$NVM_DIR/nvm.sh" ]; then
  . "$NVM_DIR/nvm.sh"  # This loads nvm
  nvm use 20.2.0 --silent
fi
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

eval "$(starship init zsh)"

export DOTNET_ROOT=$HOME/dotnet
export PATH=$PATH:$HOME/dotnet

# Keybindings
bindkey -s ^f "tmux-sessionizer\n"

# Set tmux pane name to 'copilot' instead of 'node'
# alias copilot='tmux rename-window copilot 2>/dev/null; command copilot'

source ~/dotfiles/shared/sh/rc
