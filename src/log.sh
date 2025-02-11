#!/bin/sh -e
date=$(date '+%Y-%m-%d');
datefolder=$(date '+%Y%m%d%H%M');
datestamp=$(date '+%a, %d %b %Y %T %Z'); #Tue, 28 Feb 2023 09:00:00 EST

read -p "Log Name: " name;
slug=$(echo "${name}" | tr '[:upper:]' '[:lower:]' | tr ' ' '_')
if test -d datefolder; then
	echo "Log already exists"
else
	read -p "Log Description: " description;
	cd logs;
	mkdir $datefolder;
	cd $datefolder;
	touch name.txt
	echo ${name} > name.txt
	touch date.txt
	echo ${datestamp} > date.txt
	touch content.htm
	touch meta.htm
	echo "<title>${name}</title><meta name='description' content='${description}' />" > meta.htm
fi