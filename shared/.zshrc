# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# zinit
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# Utils
source $HOME/.config/zsh/aliases.zsh
source $HOME/.config/zsh/vars.zsh
source $HOME/.config/zsh/utils.zsh

# Plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::command-not-found

# OS-specific
if [[ $(uname) == "Darwin" ]]; then # MacOS Extensions
    import_if_exists $HOME/.config/zsh/colab.zsh
    import_if_exists $HOME/.config/zsh/iterm2.zsh
    import_if_exists $HOME/.config/zsh/macos_vars.zsh
    zinit snippet OMZP::xcode
elif command -v pacman > /dev/null; then # Arch Extensions
    zinit snippet OMZP::archlinux
fi

# Tool-specific
if command -v npm > /dev/null; then
    zinit snippet OMZP::node
    zinit snippet OMZP::npm
    if command -v yarn > /dev/null; then
        zinit snippet OMZP::yarn
    fi
fi

if command -v docker > /dev/null; then
    zinit snippet OMZP::docker
    if [ ! -d "$ZSH_CACHE_DIR/completions" ] ; then
        mkdir -p "$ZSH_CACHE_DIR/completions"
    fi
    zinit snippet OMZP::docker-compose
fi

if command -v python3 > /dev/null; then
    zinit snippet OMZP::python
    zinit snippet OMZP::poetry
fi

# Theme
zinit ice depth=1; zinit light romkatv/powerlevel10k
[[ ! -f $HOME/.config/zsh/p10k.zsh ]] || source $HOME/.config/zsh/p10k.zsh

# Binds
bindkey -v
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^f' autosuggest-accept

# History
HISTSIZE=5000
HISTFILE=$HOME/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_save_no_dups
setopt hist_find_no_dups

# fzf
eval "$(fzf --zsh)"
export FZF_DEFAULT_OPTS="-e \
   --color pointer:14,hl:6,hl+:14,border:12,prompt:4"
zstyle ':fzf-tab:*' fzf-flags $(echo $FZF_DEFAULT_OPTS)
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' menu no
zstyle ':completion:*:git-checkout:*' sort false
zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'lsd --color always $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'lsd --color always $realpath'

# z
eval "$(zoxide init --cmd cd zsh)"

# Inits
autoload -U compinit && compinit
zinit cdreplay -q
unset ZSH_AUTOSUGGEST_USE_ASYNC  # Needed to fix p10k x OMZP::git
