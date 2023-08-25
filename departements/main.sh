#!/bin/bash

for dir in ./*; do 
  county_name_number=$(basename "${dir}")
  county_number=$(basename "${dir}" | awk -F '-' '{print $1}')
  url="https://geo.api.gouv.fr/departements/${county_number}/communes?fields=nom,code&format=geojson&geometry=contour"
  output_file="${dir}/communes-${county_name_number}.geojson"
  
  echo "County: ${county_number}"
  curl -X 'GET' "${url}" -H 'accept: application/json' -o "${output_file}"
done
echo "Executing 2nd script, correct formatting"
./formatting.sh &
echo "Excuting last script, simplifying"
./simplify.sh
