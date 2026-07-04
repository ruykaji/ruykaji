#!/usr/bin/env bash

WALLPAPER_DIR="$HOME/wallpapers"
ROFI_CONF="$HOME/.config/rofi/wallpaper-select.rasi"
CACHE_PATH="$HOME/.cache/current_wallpaper"

mkdir -p "$(dirname "$CACHE_PATH")"

files=$(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \))

choice=$(echo "$files" | while read -r f; do
    echo -en "$(basename "$f")\0icon\x1f$f\n"
done | rofi -dmenu -i -p "" -theme "$ROFI_CONF")

if [ -n "$choice" ]; then
    FULL_PATH=$(find "$WALLPAPER_DIR" -name "$choice" -print -quit)

    if [ -f "$FULL_PATH" ]; then
        ln -sf "$FULL_PATH" "$CACHE_PATH"

        hyprctl hyprpaper preload "$FULL_PATH"
        hyprctl hyprpaper wallpaper " ,$FULL_PATH"
        
        hyprctl hyprpaper unload unused
    fi
fi
