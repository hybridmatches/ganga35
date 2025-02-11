#!/bin/sh -e

cd content
for f in *; do
	#echo $(grep -o -P '(?<=\<a href=\"\.).*(?=\")' ./$f/content.htm)
	#echo $(sed -e 's/"<a href=\"\.\(.*\)\"\>/\1/' ./$f/content.htm)
	# 	$(grep -o "<a href=\"\.[^ ]*\"" ./$f/content.htm)
	grep -oP '<a href=\"\.\s*\K.*(?=\s+string)'
done
	