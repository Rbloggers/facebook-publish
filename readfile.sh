#!/bin/bash

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

fbtoken="fbtoken"
min=0
while IFS=$'\t' read -r title tags link
do
    printf "$min\n"
    printf "$title\n"
    printf "$tags\n"
    printf "$link\n\n"

    ## Post on Facebook
    curl -i -X POST \
     "https://graph.facebook.com/v3.2/twRblogger/feed?message=$( urlencode "${title}" )%0A$( urlencode "${tags}" )&link=$( urlencode "${link}" )&access_token=$( urlencode "${fbtoken}" )"
  
    min=$((${min} + 1))
    sleep 1
done < <(paste FB_title.txt FB_tags.txt FB_link.txt)

