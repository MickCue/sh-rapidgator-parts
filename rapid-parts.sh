#!/bin/bash

# Name: Sh Rapidgator Parts
# Version: v0.1
# Date: 24-02-2022

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
  partvalue=$(cat links | grep -oP '(?!https:\/\/rapidgator.net\/file\/.*)\w{11}.part01.rar|\w{11}.part1.rar')
  partvalue_arrVar=(${partvalue_arrVar[@]} $partvalue)
  strippart01=$(echo $partvalue | grep -oP '(?!https:\/\/rapidgator.net\/file\/.*)\w{11}.part|\w{11}.part')

  echo 'The part01 value is: '$partvalue
  echo "Downloading..."
  #echo 'Rar '$strippart01
  wget --show-progress --no-check-certificate -i links echo --header "$(cat cookies.txt)" >>/dev/null 2>&1 ||
  for value in "${partvalue_arrVar[@]}"
  do
    echo "unraring: " $value
    strippart01=$(echo $partvalue | grep -oP '(?!https:\/\/rapidgator.net\/file\/.*)\w{11}.part|\w{11}.part')
    unrar x -o+ $value >> output.md && rm $strippart01*.rar;
  done;
  echo "Download & Unrar Completed!";
  #rename -v 's/.rar.html/.rar/' *.rar.html; \


  fi
rm $1;

fi
