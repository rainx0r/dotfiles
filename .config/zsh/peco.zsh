# peco history
# Source: https://github.com/Jxck/dotfiles/blob/master/zsh/peco.zsh
function peco-select-history() {
  local tac
  if which tac > /dev/null; then
    tac="tac"
  else
    tac="tail -r"
  fi
  BUFFER=$(history -n 1 | eval $tac | awk '!a[$0]++' | peco --layout=bottom-up --query "$LBUFFER")
  CURSOR=$#BUFFER
}
zle -N peco-select-history
bindkey '^r' peco-select-history
