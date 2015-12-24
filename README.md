## Description
Batch download books from libgen  

The idea of this paste is to help optimize the download from Library Genesis
and automate the download as simply as possible using a file containing list of links  
  
A normal link from Libgen looks like this  
http://gen.lib.rus.ec/book/index.php?md5=3acf98e7e0f54c50f0e4e08d017dc320&open=0  
 
The download link for such link is   
http://gen.lib.rus.ec/get?md5=3acf98e7e0f54c50f0e4e08d017dc320&open=0  
 
Now we can easily make a list of download links and save them in a file then input them in wget  
wget -i list  
 
But still the problem would be that each file would be saved with a weird name
To solve this problem we have to create a file of list of output filenames from the source link
then assign for each file its respective filename  
 
Using sed and wget -qO- we can get the title for each link from the source and save the output  
wget -qO- -i list.urls | sed -n -e 's!.*Genesis: \(.*\)</title>.*!\1!p' > list.names  
 
Now we should create the list of download links from normal links  
sed 's:book/index.php:get:g' list.urls > list.downloads  
 
Now that everything seems cool we execute the script  
while read durl name; do wget -c "$durl" -O "$name"; done < <(paste list.downloads list.names)  
 
 
