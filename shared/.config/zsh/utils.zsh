import_if_exists() {
    if [ -f "$1" ]; then
        source "$1"
    else
        echo "Warning: File $1 not found. Skipping import." >&2
    fi
}

print_p10k_colours() {
    for i in {0..255}; do print -Pn "%K{$i}  %k%F{$i}${(l:3::0:)i}%f " ${${(M)$((i%6)):#3}:+$'\n'}; done
}
