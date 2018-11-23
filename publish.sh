#!/bin/bash

## Encode URL
function urlencode() {
    local length="${#1}"
    for (( i = 0; i < length; i++ )); do
        local c="${1:i:1}"
        case $c in
            [a-zA-Z0-9.~_-]) printf "$c" ;;
            *) printf "$c" | xxd -p -c1 | while read x;do printf "%%%s" "$x";done
        esac
    done
}


## Post on Facebook
min=30  # First post scheduled in $min minutes
postperday=5
num=0
day=0
while IFS=$'\t' read -r title tags link
do
    num=$((${num} + 1))
    
    # Deal with empty tags
    if [[ $tags == "#" ]]; then tags=""; fi  
    
    date=$(echo $(date --date="+${min} minutes" +%s))
    
    curl -i -X POST \
     "https://graph.facebook.com/v3.2/twRblogger/feed?published=false&message=$( urlencode "${title}" )%0A$( urlencode "${tags}" )&link=$( urlencode "${link}" )&access_token=$( urlencode "${fbtoken}" )&scheduled_publish_time=${date}"

    printf "\nPost: ${num}\n"
    # Push publish date furthur if too many posts
    if [[ ${num} -gt ${postperday} ]]; then
        day=$((${num} - ${postperday}))
    fi
    
    min=$((${min} + 8 + 1440 * ${day}))
    sleep 0.3
done < <(paste FB_title.txt FB_tags.txt FB_link.txt)

