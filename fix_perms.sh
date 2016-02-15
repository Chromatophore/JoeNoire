echo "Fixing permissions to 644 (744 for folders)"
find ./data/ -type f -exec chmod 644 {} \;
find ./data/ -type d -exec chmod 745 {} \;
find ./*.pde -exec chmod 644 {} \;