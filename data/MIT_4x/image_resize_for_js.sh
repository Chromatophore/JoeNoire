echo "Converting all textures by magnitude 4x"
find */*.png -type f -exec mogrify -resize 400% -filter Point {} \;