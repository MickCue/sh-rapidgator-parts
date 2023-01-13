#!/bin/bash

# Name: Sh Rapidgator Parts
# Version: v0.4
# Date: 13-01-2023

# Description: Download list of rapidgator URL's rar parts and extract automatically

# Usage: ./rapid-parts.sh url-list.md
# Authentication: Copy cookie values to text file cookies.txt


filename=$1
filetitle=title
exe1=false

echo "Pinging URLs..."

while read p; do
  if [[ "$p" =~ ^http.* ]];then
  #echo "Testing: $url"
        res1=$(curl -Ls $p)
        #echo $res1 > test.html
        if [[ $res1 != *"Downloading"* ]]; then
        #if [[ $res1 != *"This file can be downloaded by premium only"* ]]; then
    #if [[ $res1 == *"404 File not found"* ]]; then
    echo "Deadlink, removing all occureneces of: $p"
    delethese=$(grep -v '(?!https:\/\/rapidgator.net\/file\/.*)\w{11}.part|\w{11}.part')
    grep -v $delethese $1 > tmpfile && mv tmpfile $1
    #rm $1
          exit 1
    else
          echo "Alive: $p"
    #filehash = $p | grep -o -P "((?<=)[A-Za-z0-9]{11}(?=.pa))"
          exe1=true
          fi

  else
  if [[ -n "$p" ]]; then
    echo "Title:$p"
    fi
  fi
  #echo $res1 > response.html

done <$filename
if [[ $exe1 == "true" ]];then
  echo "Links are alive for downloads"

   if [[ $exe1 = true ]]; then
    echo "List of URLs are ALIVE"
  # Remove Empty
  sed '/^((?!https).*$)/d' $filename  > links
  partvalue=$(cat links | grep -oP '([a-zA-Z0-9]+.part1.rar)|([a-zA-Z0-9]+.part01.rar)')
  partvalue_arrVar=(${partvalue_arrVar[@]} $partvalue)
  strippart01=$(echo $partvalue | grep -oP '(?!https:\/\/rapidgator.net\/file\/.*)\w{11}.part|\w{11}.part')

  echo 'The part01 value is: '$partvalue
  echo "Downloading..."
  # Remove trailing .html
  sed -e s/.html//g -i links
  cat links | xargs -n 1 -P 10 wget --retry-connrefused  --read-timeout=20 --timeout=15 --tries=0 --continue  --no-check-certificate -4 -i --cookies=off --header "$(cat cookies.txt)" >>/dev/null 2>&1  ||
  #wget --show-progress --no-check-certificate -i links echo --header "$(cat cookies.txt)" >>/dev/null 2>&1 ||
  #for value in "${partvalue_arrVar[@]}"
  #do
  echo "unraring: " $partvalue
  strippart01=$(echo $partvalue | grep -oP '(?!https:\/\/rapidgator.net\/file\/.*)\w{11}.part|\w{11}.part')
  unrar x -o+ $partvalue >> output.md
  echo "File Extracted:"
  grep mkv output.md | tail -1 | grep -oP "(\w.*).*(.mkv)"
  #done;

  echo "Download & Unrar Completed!";

  fi
rm $1;
rm *.rar

fi
