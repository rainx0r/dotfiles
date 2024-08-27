link_dotfiles() {
    stow -t $HOME --adopt macos
    stow -t $HOME --adopt shared
}

