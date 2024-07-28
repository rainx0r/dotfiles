SKIP_SYSTEM_DEPS=false
SKIP_LINKS=false
SKIP_PKG_DEPS=false

# Parse command line arguments
for arg in "$@"
do
    if [ "$arg" = "--no-system" ]
    then
        SKIP_SYSTEM_DEPS=true
    elif [ "$arg" = "--no-links" ]
    then
        SKIP_LINKS=true
    elif [ "$arg" = "--no-packages" ]
    then
        SKIP_PKG_DEPS=true
    fi
done

if [ "$SKIP_SYSTEM_DEPS" = false ]
then
    # Install dependencies
    sudo pacman -S stow 
else
    echo "Skipping system installs"
fi

# Symlink files
if [ "$SKIP_LINKS" = false ]
then
    if [ ! -d "shared" ]; then
        echo "Please call this script from the root of the 'dotfiles' directory." >&2
        exit 1
    fi
    stow -t $HOME --adopt shared
else
    echo "Skipping symlinks"
fi

# Install software
if [ "$SKIP_PKG_DEPS" = false ]
then
    # Install dependencies
    sudo pacman -S bat lsd fzf zoxide ripgrep
else
    echo "Skipping package dependencies"
fi
