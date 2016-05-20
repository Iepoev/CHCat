#!/bin/bash

DB=/home/jeroen/Documents/Github/CHCat/db.csv

rm $DB
touch $DB
for file in $(find htmlfiles/ -name '*.html')
do
  echo "$file"
  grep 'PricesalesPriceWithDiscount\|browseProductImage' $file > $file"tmp.txt"
  sed -i 's/.*>\([0-9]\+,[0-9]\+\) €.*/\1€/g' $file"tmp.txt" #get price
  sed -i 's/.*src="\(.*\.\(jpg\|png\|gif\)\)".*title="\(.*\)"  \/><\/a>/\1;\3/g' $file"tmp.txt" #get title and box
  tr '\n' ';' < $file"tmp.txt" > $file".txt" # get everything on one line
  rm $file"tmp.txt"
  sed -i 's/€;/€\n/g' $file".txt" # split line after every price
  sed -i 's/\(.*;.*\)\(;.*\)/\1;1?\2/g' $file".txt" # split line after every price
  sed -i 's/\(.*\) \/\([0-9]\+.*\);1?/\1;\2/g' $file".txt" #if boxamount present, put boxamount in its field
  cat $file".txt" >> "$DB"
  #rm $file".txt"
done
