#!/bin/bash

DB=/home/jeroen/Documents/Github/CHCat/db.csv

rm $DB
touch $DB
#for file in $(find htmlfiles/belgian-cigars/full-boxes-4/ -name '*.html')
for file in $(find htmlfiles/ -name '*.html')
do
  echo "$file"

  #get raw html data
  grep 'PricesalesPriceWithDiscount\|browseProductImage' $file > $file"tmp.txt"

  #parse primary data
  sed -i -e 's/.*>\([0-9]\+,[0-9]\+\) €.*/\1€/g' -e 's/.*src="\(.*\.\(jpg\|png\|gif\)\)".*title="\(.*\)"  \/><\/a>/\1;\3/g' $file"tmp.txt"

  # set everything on one line
  tr '\n' ';' < $file"tmp.txt" > $file".txt"
  rm $file"tmp.txt"

  #if boxamount is present, put boxamount in its field, if not, set it to "1?"
  sed -i -e 's/,\([0-9]\+\)€;/.\1€\n/g' -e 's/\(.*;.*\)\(;.*\)/\1;1\2/g' -e 's/\(.*\) \/\([0-9]\+.*\);1/\1;\2/g' $file".txt"

  #add categories, remove timestamps and other junk
  IFS='/' read -ra ADDR <<< "$file"
  unset ADDR[${#ADDR[@]}-1]
  sed -i -e "s/$/;${ADDR[1]}/g" -e "s/$/;${ADDR[2]}/g" -e "s/$/;${ADDR[3]}/g" \
  -e "s/[0-9]\+-[0-9]\+-[0-9]\+-[0-9]\+-[0-9]\+-[0-9]\+//g" -e "s/-[0-9]\+;/;/g" $file".txt"

  #write to db and cleanup
  cat $file".txt" >> "$DB"
  rm $file".txt"
done
