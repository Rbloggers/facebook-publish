#!/bin/bash
sleep 0.5
echo "START CHECKING"

RED='\033[0;31m'
NC='\033[0m'
error=0

## Check existance of new post
[ -s FB_title.txt ] || printf "No new post.\nNo curl request sent.\n" && exit 0

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
