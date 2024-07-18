SKIP_INSTALL=false

# Parse command line arguments
for arg in "$@"
do
    if [ "$arg" = "--no-install" ]
    then
        SKIP_INSTALL=true
    fi
done

if [ "$SKIP_INSTALL" = false ]
then
    # Install Oh My Zsh
    curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh

    # Install brew
    curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh
    brew install stow
else
    echo "Skipping Oh My Zsh & brew installs"
fi

# Symlink files
if [ ! -d "macos" ] && [ ! -d "shared" ]; then
    echo "Please call this script from the root of the 'dotfiles' directory." >&2
    exit 1
fi
stow -t $HOME --adopt macos
stow -t $HOME --adopt shared

# Install software
# - Software via brew
brew bundle --file ~/.config/Brewfile

# Set up VSCode
cp -r vscode/* ~/Library/Application\ Support/Code/User/

# Set Safari CSS
defaults write com.apple.safari UserStyleSheetEnabled 1\
 && defaults write com.apple.safari UserStyleSheetLocationURLString "~/.config/safari.css"\
 && defaults write com.apple.safari WebKitUserStyleSheetEnabledPreferenceKey 1\
 && defaults write com.apple.safari WebKitUserStyleSheetLocationPreferenceKey "~/.config/safari.css"
