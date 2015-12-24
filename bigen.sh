#!/bin/bash 
wget -qO- -i list.urls | sed -n -e 's!.*Genesis: \(.*\)</title>.*!\1!p' > list.names
sed 's:book/index.php:get:g' list.urls > list.downloads
while read durl name; do wget -c "$durl" -O "$name"; done < <(paste list.downloads list.names)
rm list.downloads list.names
