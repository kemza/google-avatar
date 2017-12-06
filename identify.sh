#!/bin/bash

### Parameters ###
EMAIL="$1"
DIR="$2"
FILENAME=$DIR/identify-$1
ESC_FILENAME="${FILENAME//./_}"

URL="https://image.devidentify.com/$1" #?default=null

### Body ###

if curl --output /dev/null --silent --head --fail "$URL"; 
then
  echo "   OK: downloading picture from Devidentify"
  curl -L -s $URL > $ESC_FILENAME
else
  echo "   Error: Devidentify not found"
fi