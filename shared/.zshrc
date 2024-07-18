bindkey -v

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="agnoster"
DEFAULT_USER=evangelos-ch
prompt_context() {}

COMPLETION_WAITING_DOTS="true"

plugins=(git sudo web-search z vscode node npm yarn python poetry docker xcode vi-mode)

source $ZSH/oh-my-zsh.sh
source $HOME/.config/zsh/utils.zsh

export LANG=en_US.UTF-8
export EDITOR=vim

alias ls='lsd'
alias lt='ls --tree'
alias l='ls -l'
alias lla='ls -la'
alias la='ls -a'

alias cat='bat --paging=never'

# MacOS Extensions
import_if_exists $HOME/.config/zsh/colab.zsh
import_if_exists $HOME/.config/zsh/iterm2.zsh
import_if_exists $HOME/.config/zsh/vars.zsh
