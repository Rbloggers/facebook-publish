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


## Variables
title='部落客 English'
tags='#R #R部落'
link='https://liao961120.github.io/2018/09/09/linguistics-down.html'

date=$(echo $(date --date="+1 minutes" +%s))

## Post on Facebook
curl -i -X POST \
 "https://graph.facebook.com/v3.2/twRblogger/feed?published=false&message=$( urlencode "${title}" )%0A$( urlencode "${tags}" )&link=$( urlencode "${link}" )&access_token=$( urlencode "${fbtoken}" )&scheduled_publish_time=${date}"
 
# ?published=false&message=$( rawurlencode "$title" )&scheduled_publish_time=+${min} minutes
 
#https://developers.facebook.com/docs/pages/publishing?locale=zh_TW
 
