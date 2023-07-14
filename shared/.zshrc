export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="agnoster"
DEFAULT_USER=evangelos-ch
prompt_context() {}

COMPLETION_WAITING_DOTS="true"

plugins=(git z vscode node npm yarn python poetry docker xcode)

source $ZSH/oh-my-zsh.sh

export LANG=en_US.UTF-8
export EDITOR=vim

alias ls='exa --group-directories-first --icons --color-scale -l -g' # --time-style=iso
alias lt='exa --tree --level=2 --icons' # Show in tree view
alias l='ls -a'                         # Short, all files
alias ld='l -D'                         # Short, only directories
alias ll='ls -lbG --git'                # Long, file size prefixes, grid, git status
alias la='ll -a'                        # Long, all files
alias lC='la --sort=changed'            # Long, sort changed
alias lM='la --sort=modified'           # Long, sort modified
alias lS='la --sort=size'               # Long, sort size
alias lX='la --sort=extension'          # Long, sort extension

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

source ~/.config/zsh/peco.zsh
