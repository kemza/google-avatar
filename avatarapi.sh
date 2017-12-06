#!/bin/bash

### Parameters ###
EMAIL="$1"
DIR="$2"

URL="https://www.avatarapi.com/js.aspx?email=$1&size=256"

### Body ###

if curl --output /dev/null --silent --head --fail "$URL"; 
then
  echo "   OK: downloading picture from Avatarapi"
  curl -s $URL > $DIR/avatarapi-$1.jpg
  #wget $URL > $DIR/devidentify-$1.jpg
else
  echo "   Error: Avatarapi not found"
fi