## Encode URL
rawurlencode() {
  local string="${1}"
  local strlen=${#string}
  local encoded=""
  local pos c o

  for (( pos=0 ; pos<strlen ; pos++ )); do
     c=${string:$pos:1}
     case "$c" in
        [-_.~a-zA-Z0-9] ) o="${c}" ;;
        * )               printf -v o '%%%02x' "'$c"
     esac
     encoded+="${o}"
  done
  echo "${encoded}"    # You can either set a return variable (FASTER) 
  REPLY="${encoded}"   #+or echo the result (EASIER)... or both... :p
}


## Variables
message='From travis'
link='https://liao961120.github.io/2018/09/09/linguistics-down.html'


## Post on Facebook
curl -i -X POST \
 "https://graph.facebook.com/v3.2/twRblogger/feed?message=$( rawurlencode "$message" )&link=$( rawurlencode "$link" )&access_token=$( rawurlencode "$fbtoken" )"
 
 
 
 
 
