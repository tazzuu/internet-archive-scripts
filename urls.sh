#!/bin/bash
set -euo pipefail

# cat urls.txt | parallel -j 4 wget "{}"

printf '' > urls.txt
for i in *.html; do
echo ">>> $i"
URLBASE="$(echo "$i" | sed -e 's|\(^.*\) directory listing.html|\1|g')"
URLS="$(grep -E '.torrent|.mkv|.avi|.mp4' "$i" | grep '<a href=' | sed -e 's|.*href="\([^"]*\).*>|\1|p')"
while IFS= read -r url; do
printf "https://archive.org/download/%s/%s\n" "$URLBASE" "$url"  >> urls.txt
done <<< "$URLS"
done
