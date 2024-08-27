setup_vsc() {
    echo "- Setting up VSCode..."
    cp -r vscode/* ~/Library/Application\ Support/Code/User/
    echo "- - VSCode set up!"
}

setup_safari() {
    # Set Safari CSS
    echo "- Setting up Safari CSS..."
    defaults write com.apple.safari UserStyleSheetEnabled 1 && defaults write com.apple.safari UserStyleSheetLocationURLString "$HOME/.config/safari.css" &&
        defaults write com.apple.safari WebKitUserStyleSheetEnabledPreferenceKey 1 && defaults write com.apple.safari WebKitUserStyleSheetLocationPreferenceKey "$HOME/.config/safari.css"
    echo "- - Safari CSS set up!"
}
