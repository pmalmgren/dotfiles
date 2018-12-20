export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="agnoster"

plugins=(
  git
  zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

source $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

if [ -f ~/.zshrc.local ]; then
    source ~/.zshrc.local
fi
