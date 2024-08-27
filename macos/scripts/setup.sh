SKIP_INSTALL=false
SKIP_LINKS=false
SKIP_BREW=false
SKIP_MISC=false

# Parse command line arguments
for arg in "$@"; do
    if [[ $arg = "--no-system" ]]; then
        SKIP_INSTALL=true
    elif [[ $arg = "--no-links" ]]; then
        SKIP_LINKS=true
    elif [[ $arg = "--no-brew" ]]; then
        SKIP_BREW=true
    elif [[ $arg = "--no-misc" ]]; then
        SKIP_MISC=true
    fi
done

if [ ! -d "macos" ] && [ ! -d "shared" ]; then
    echo "Please call this script from the root of the 'dotfiles' directory." >&2
    exit 1
fi

source macos/scripts/installs.sh
source macos/scripts/software.sh
source macos/scripts/links.sh

if [[ $SKIP_INSTALL = false ]]; then
    install_system_deps
else
    echo "Skipping system installs"
fi

# Symlink files
if [[ $SKIP_LINKS = false ]]; then
    link_dotfiles
else
    echo "Skipping symlinks"
fi

# Install software
if [[ $SKIP_BREW = false ]]; then
    brew bundle --file ~/.config/Brewfile
else
    echo "Skipping brew installs"
fi

if [[ $SKIP_MISC = false ]]; then
    setup_vsc
    setup_safari
else
    echo "Skipping misc configurations"
fi
