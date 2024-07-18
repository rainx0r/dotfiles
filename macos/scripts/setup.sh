SKIP_INSTALL=false
SKIP_LINKS=false
SKIP_BREW=false
SKIP_MISC=false

# Parse command line arguments
for arg in "$@"
do
    if [ "$arg" = "--no-system" ]
    then
        SKIP_INSTALL=true
    elif [ "$arg" = "--no-links" ]
    then
        SKIP_LINKS=true
    elif [ "$arg" = "--no-brew" ]
    then
        SKIP_BREW=true
    elif [ "$arg" = "--no-misc" ]
    then
        SKIP_MISC=true
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
    echo "Skipping system installs"
fi

# Symlink files
if [ "$SKIP_LINKS" = false ]
then
    if [ ! -d "macos" ] && [ ! -d "shared" ]; then
        echo "Please call this script from the root of the 'dotfiles' directory." >&2
        exit 1
    fi
    stow -t $HOME --adopt macos
    stow -t $HOME --adopt shared
else
    echo "Skipping symlinks"
fi

# Install software
if [ "$SKIP_BREW" = false ]
then
    brew bundle --file ~/.config/Brewfile
else
    echo "Skipping brew installs"
fi

# Set up VSCode
if [ "$SKIP_MISC" = false ]
then
    echo "- Setting up VSCode..."
    cp -r vscode/* ~/Library/Application\ Support/Code/User/
    echo "- - VSCode set up!"

    # Set Safari CSS
    echo "- Setting up Safari CSS..."
    defaults write com.apple.safari UserStyleSheetEnabled 1\
    && defaults write com.apple.safari UserStyleSheetLocationURLString "~/.config/safari.css"\
    && defaults write com.apple.safari WebKitUserStyleSheetEnabledPreferenceKey 1\
    && defaults write com.apple.safari WebKitUserStyleSheetLocationPreferenceKey "~/.config/safari.css"
    echo "- - Safari CSS set up!"
else
    echo "Skipping misc configurations"
fi
