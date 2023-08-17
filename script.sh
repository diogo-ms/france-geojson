#!/bin/bash
files="./regions/*/departements-*"

for file in $files; 
do 
    echo "greping... $file" 
    grep -rl "nom" $file | xargs sed -i 's/nom/name/g' 
    echo "correctly formatting .geojson files" 
    cat $file | jq -c '.features[] |= (.id = .properties.code | del(.properties.code))' >$file.tmp 
    echo "moving the temporary file into the original" 
    mv $file.tmp $file 
done 
