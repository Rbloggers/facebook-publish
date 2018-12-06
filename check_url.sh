#!/bin/bash

RED='\033[0;31m'
NC='\033[0m'
err=0

## Check existance of new post
if [ ! -s FB_title.txt ]; then
    printf "No new post.\nNo curl request sent.\n"
    exit 0
fi

## Check existance of post on Rbloggers.github.io
while read url; do
    status=$(curl -Is "${url}" | head -1 | grep -o "200")
    if [[ ${status} != "200" ]]; then
        printf "${RED}FAILED ${url}${NC}\n"
        err=1
    else
        printf "Get ${url}\n"
    fi
done < FB_link.txt


## Check Publication history on FB
while read url; do
    ## Check publish history on FB
    if grep -Fxq "${url}" history/hist_link.txt; then
        echo "${RED}${url} ${NC}already published on FB."
        err=1
    fi
done < FB_link.txt


[[ ${err} == "1" ]] && printf "${RED}TERMINATE 404\n" && exit 404
printf "\nAll URLs Exist\nExit 0\n"
