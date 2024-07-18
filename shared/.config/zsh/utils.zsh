import_if_exists() {
    if [ -f "$1" ]; then
        source "$1"
    else
        echo "Warning: File $1 not found. Skipping import." >&2
    fi
}
