#!/bin/bash

### YOU WILL NEED csvtool, curl and exiftool

### Parameters ###
DIR=~/avatar

### Body ###

if [ ! -d $DIR ]; then
  echo "Make directory $DIR"
  mkdir $DIR;
fi


csvtool col 29  google.csv > temp-google.csv
csvtool col 31  google.csv >> temp-google.csv
csvtool col 33  google.csv >> temp-google.csv

while read -r LINE
do
    if [[ $LINE =~ .*@.* ]]
    then
	echo "searching picture for $LINE"
	./gravatar.sh $LINE $DIR
	./identify.sh $LINE $DIR
	#./avatarapi.sh $LINE $DIR
    sleep 5s
    fi
done < temp-google.csv

rm temp-google.csv

cd $DIR;

exiftool -if '$filetype eq "JPEG"' -filename=%f.jpg \
-execute -if '$filetype eq "PNG"' -filename=%f.png \
-execute -if '$filetype eq "TIFF"' -filename=%f.tiff \
-common_args -r -ext '' .

