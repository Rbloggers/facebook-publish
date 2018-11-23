#!/bin/bash

RED='\033[0;31m'
NC='\033[0m'
error=0

while read url; do
    status=$(curl -Is "${url}" | head -1 | grep -o "200")
    if [[ ${status} != "200" ]]; then
        printf "${RED}FAILED ${url}${NC}\n"
        error=1
    else
        printf "Get ${url}\n"
    fi
done < FB_link.txt

[[ ${error} == "1" ]] && printf "${RED}TERMINATE 404\n" && exit 404
printf "\nAll URLs Exist\nExit 0\n"
