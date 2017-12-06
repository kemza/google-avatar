#!/bin/bash

### Parameters ###
EMAIL="$1"
DIR="$2"
FILENAME=$DIR/gravatar-$1
ESC_FILENAME="${FILENAME//./_}"
PICTURE_SIZE='512'

### Body ###

HASH=`echo -n $EMAIL | awk '{print tolower($0)}' | tr -d '\n ' | md5sum --text | tr -d '\- '`
URL="http://www.gravatar.com/avatar/$HASH?s=$PICTURE_SIZE&d=404"


if curl --output /dev/null --silent --head --fail "$URL"; 
then
  echo "   OK: downloading picture from Gravatar"
  curl -s $URL > $ESC_FILENAME
else
  echo "   Error: Gravatar not found"
fi