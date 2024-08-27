install_brew() {
    # Install brew
    curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh
    brew install stow
}

install_nix() {
    sh <(curl -L https://nixos.org/nix/install)
}

install_system_deps() {
    # install_nix
    install_brew
    brew install stow
}
