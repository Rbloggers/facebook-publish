#!/bin/bash

## New Posts to Publish on FB
curl --silent --show-error --fail https://raw.githubusercontent.com/Rbloggers/Rbloggers.github.io/posts/FB_title.txt > FB_title.txt
curl --silent --show-error --fail https://raw.githubusercontent.com/Rbloggers/Rbloggers.github.io/posts/FB_link.txt > FB_link.txt
curl --silent --show-error --fail https://raw.githubusercontent.com/Rbloggers/Rbloggers.github.io/posts/FB_tags.txt > FB_tags.txt

sed "s/\(,\)$//" FB_tags.txt > temp   # remove trailing comma
sed "s/ /_/g" temp > temp2            # sub space(in tag) with _
sed "s/,/ #/g" temp2 > temp3          # sub comma with space+hash
sed "s/^/#/" temp3 > FB_tags.txt      # Add leading hash

rm -r temp*


## History of Publication on FB
[[ -d history ]] || mkdir history

curl --silent --show-error --fail https://raw.githubusercontent.com/Rbloggers/facebook-publish/history/hist_title.txt > history/hist_title.txt
curl --silent --show-error --fail https://raw.githubusercontent.com/Rbloggers/facebook-publish/history/hist_tags.txt > history/hist_tags.txt
curl --silent --show-error --fail https://raw.githubusercontent.com/Rbloggers/facebook-publish/history/hist_link.txt > history/hist_link.txt

### INTERRUPT: Empty history
#> history/hist_title.txt
#> history/hist_tags.txt
#> history/hist_link.txt
