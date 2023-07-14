CWD = $(pwd)

# Install Oh My Zsh
curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh

# Install brew
curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh

# Copy config files
cd $CWD
cp -r $CWD/../shared/* ~/
cp -r .config/* ~/.config/
cp -r $CWD/../vscode/* ~/Library/Application\ Support/Code/User/

# Install software
# - Software via brew
brew bundle --file ~/.config/Brewfile

# - Software via App Store (in order): Things 3
mas install 904280696 

# Ubersicht widgets
cd ~/Library/Application Support/Übersicht/widgets

ghq get evangelos-ch/UeberPlayer
ln -s ~/Documents/Repositories/github.com/evangelos-ch/UeberPlayer/UeberPlayer.widget UeberPlayer.widget

ghq get evangelos-ch/simple-bar
ln -s ~/Documents/Repositories/github.com/evangelos-ch/simple-bar simple-bar 

ghq get evangelos-ch/current-task
ln -s ~/Documents/Repositories/github.com/evangelos-ch/current-task current-task

# Set Safari CSS
defaults write com.apple.safari UserStyleSheetEnabled 1\
 && defaults write com.apple.safari UserStyleSheetLocationURLString "~/.config/safari.css"\
 && defaults write com.apple.safari WebKitUserStyleSheetEnabledPreferenceKey 1\
 && defaults write com.apple.safari WebKitUserStyleSheetLocationPreferenceKey "~/.config/safari.css"
