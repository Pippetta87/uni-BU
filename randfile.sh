files=(~/Images/i3-wallpapers/*)
printf "%s\n" "${files[RANDOM % ${#files[@]}]}"
