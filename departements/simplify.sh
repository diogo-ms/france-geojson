#!/bin/bash
#
files="./*/communes-*.geojson"

for file in $files; 
do
  mapshaper $file -simplify 25% weighted keep-shapes -o format=geojson force $file precision 0.00001
done
