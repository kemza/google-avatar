#!/bin/bash

### YOU WILL NEED csvtool, curl and exiftool

### Parameters ###
INPUT_DIR=./data
OUTPUT_DIR=~/avatar

### Body ###

if [ ! -d $OUTPUT_DIR ]; then
  echo "Make directory $OUTPUT_DIR"
  mkdir $OUTPUT_DIR;
fi


csvtool col 29  $INPUT_DIR/google.csv > $INPUT_DIR/temp-google.csv
csvtool col 31  $INPUT_DIR/google.csv >> $INPUT_DIR/temp-google.csv
csvtool col 33  $INPUT_DIR/google.csv >> $INPUT_DIR/temp-google.csv

while read -r LINE
do
    if [[ $LINE =~ .*@.* ]]
    then
	echo "searching picture for $LINE"
	./gravatar.sh $LINE $OUTPUT_DIR
	./identify.sh $LINE $OUTPUT_DIR
	#./avatarapi.sh $LINE $INPUT_DIR $OUTPUT_DIR
    sleep 5s
    fi
done < $INPUT_DIR/temp-google.csv

rm $INPUT_DIR/temp-google.csv

cd $OUTPUT_DIR;

exiftool -if '$filetype eq "JPEG"' -filename=%f.jpg \
-execute -if '$filetype eq "PNG"' -filename=%f.png \
-execute -if '$filetype eq "TIFF"' -filename=%f.tiff \
-common_args -r -ext '' .

echo "Done."