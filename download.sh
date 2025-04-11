#!/bin/bash 
set -euxo pipefail

cat urls.txt | parallel -j 8 --joblog download.log --resume-failed wget -c -nv --show-progress '{}'
