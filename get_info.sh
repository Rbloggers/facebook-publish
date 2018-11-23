#!/bin/bash

curl --silent --show-error --fail https://raw.githubusercontent.com/Rbloggers/web/posts/FB_title.txt > FB_title.txt
curl --silent --show-error --fail https://raw.githubusercontent.com/Rbloggers/web/posts/FB_link.txt > FB_link.txt
curl --silent --show-error --fail https://raw.githubusercontent.com/Rbloggers/web/posts/FB_tags.txt > FB_tags.txt

echo "FINISH cURL"

echo "START sed"

sed "s/\(,\)$//" FB_tags.txt > temp   # remove trailing comma
sed "s/ /_/g" temp > temp2            # sub space(in tag) with _
sed "s/,/ #/g" temp2 > temp3          # sub comma with space+hash
sed "s/^/#/" temp3 > FB_tags.txt      # Add leading hash

rm -r temp*
