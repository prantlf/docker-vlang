#!/bin/sh

set -e

curl -s -o vrel.txt https://api.github.com/repos/vlang/v/releases/latest
cat vrel.txt | jq -r '.name' > vname.txt
echo "last v release $(cat vname.txt)"
cat vrel.txt | jq -r '.tag_name' > vtag.txt
echo "last v tag $(cat vtag.txt)"

# ZIPURL=`echo $vrel | jq -r '.assets[] | select(.name=="v_linux.zip").browser_download_url'`
# echo "Found $vname at $ZIPURL"
# echo "Downloading the archive"
# curl -sL -o v_linux.zip $ZIPURL

curl -s -o drel.txt https://api.github.com/repos/prantlf/docker-vlang/releases/latest
cat drel.txt | jq -r '.name' > dname.txt
echo "last docker release $(cat dname.txt)"
