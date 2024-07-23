# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"
DEFAULT_USER=evangelos-ch
prompt_context() {}

COMPLETION_WAITING_DOTS="true"

plugins=(
    git sudo
    web-search
    z
    vscode
    node npm yarn
    python poetry
    docker
    xcode
    vi-mode
    zsh-autosuggestions
    zsh-syntax-highlighting
    fzf-tab
)

# NOTE https://github.com/zsh-users/zsh-completions/issues/603
fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src

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

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f $HOME/.config/zsh/p10k.zsh ]] || source $HOME/.config/zsh/p10k.zsh

# fzf
eval "$(fzf --zsh)"
zstyle ':completion:*:git-checkout:*' sort false
# zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' menu no
zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'lsd --color always $realpath'
