#! /usr/bin/env bash

preview_image() {
    file=$1
    w=$2
    h=$3
    x=$4
    y=$5

    # Rescale the image
    w=$(( w * 99 / 100 ))
    h=$(( h * 99 / 100 ))

    if [ "$file" = "-" ]; then
        cat - | kitty +kitten icat --silent --stdin yes --transfer-mode file --place "${w}x${h}@${x}x${y}" > /dev/tty
    else
        kitty +kitten icat --silent --stdin no --transfer-mode file --place "${w}x${h}@${x}x${y}" "$file" < /dev/null > /dev/tty
    fi
}

preview_text() {
    bat --color=always -n "$1"
    exit 0
}

case "$1" in
    *.tar.*|*.tar)
        tar tf "$1"
        exit 0
esac

mime=$(file --dereference --mime-type -b "$1")

case "$mime" in
    image/*)
        preview_image "$1" "$2" "$3" "$4" "$5"
        exit 1
        ;;
    application/pdf)
        pdftoppm -jpeg -f 1 -singlefile "$1" | preview_image "-" "$2" "$3" "$4" "$5"
        exit 1
        ;;
    text/*|application/json|application/javascript)
        preview_text "$1"
        ;;
    *)
        echo "No preview available"
        echo -e "\e[90m"
        echo "$mime"
        stat "$1"
        echo -e "\e[0m"
        ;;
esac
exit 0
