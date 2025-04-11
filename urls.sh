#!/bin/bash
set -euo pipefail

# make the file urls.txt out of all the scraped URL's from all the source .html input files
# which are the directory listings saved from Internet Archive pages

# download with;
# cat urls.txt | parallel -j 4 wget "{}"

printf '' > urls.txt
for i in *.html; do
echo ">>> $i"

# get the base URL from the filename
# if you used the web broswer it will be "fooo directory listing.html"
URLBASE="$(echo "$i" | sed -e 's|\(^.*\) directory listing.html|\1|g')"
# if you used wget it will just be "fooo.html" so strip that as well
URLBASE="$( echo $URLBASE | sed -e 's|.html||g' )"

# scrape all the embedded URLs to the files we want to download
URLS="$(grep -E '.torrent|.mkv|.avi|.mp4' "$i" | grep '<a href=' | sed -e 's|.*href="\([^"]*\).*>|\1|p')"
while IFS= read -r url; do
(
    # set -x # uncommentthis for debugging

    # paste the direct URL to each file back together
    printf "https://archive.org/download/%s/%s\n" "$URLBASE" "$url"  >> urls.txt
    )
done <<< "$URLS"
done

# get rid of duplicate lines
sort -u urls.txt > .tmp && /bin/mv .tmp urls.txt