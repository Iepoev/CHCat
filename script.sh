#!/bin/bash

DB=/home/jeroen/Documents/Github/CHCat/db.csv

rm $DB
touch $DB
for file in $(find htmlfiles/ -name '*.html')
do
  echo "$file"
  grep 'PricesalesPriceWithDiscount\|browseProductImage' $file > $file"tmp.txt"
  sed -i 's/.*>\([0-9]\+,[0-9]\+\) €.*/\1€/g' $file"tmp.txt"
  sed -i 's/.*src="\(.*\.jpg\)".*title="\(.*\)\ \/\([0-9]\+\)"  \/><\/a>/\1;\2;\3/g' $file"tmp.txt"
  tr '\n' ';' < $file"tmp.txt" > $file".txt"
  rm $file"tmp.txt"
  sed -i 's/€;/€\n/g' $file".txt"
  cat $file".txt" >> "$DB"
  rm $file".txt"
done
