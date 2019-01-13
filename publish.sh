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


## Check existance of new post
if [ ! -s FB_title.txt ]; then
    printf "No new post.\nNo curl request sent.\n"
    exit 0
fi


## Post on Facebook
min=1100  #60  # First post scheduled in $min minutes
postperday=3
num=0
cross_day=2
while IFS=$'\t' read -r title tags link
do
    num=$((${num} + 1))

    
    ## Publish posts
    date=$(echo $(date --date="+${min} minutes" +%s))
    if [[ $tags == "#" ]]; then tags=""; fi  

    curl -i -X POST \
     "https://graph.facebook.com/v3.2/twRblogger/feed?published=false&message=$( urlencode "${title}" )%0A$( urlencode "${tags}" )&link=$( urlencode "${link}" )&access_token=$( urlencode "${fbtoken}" )&scheduled_publish_time=${date}"

 
    ## Record publish history
    echo "${title}" >> history/hist_title.txt
    echo "${tags}" >> history/hist_tags.txt
    echo "${link}" >> history/hist_link.txt   


    ## Push publish date furthur if too many posts
    printf "\nPost: ${num}\n"
    if [[ ${num} -gt ${postperday} ]]; then 
        min=$((${min} + 1440 * ${cross_day}))
    else
        min=$((${min} + 8))
    fi
    
    sleep 0.3
done < <(paste FB_title.txt FB_tags.txt FB_link.txt)
