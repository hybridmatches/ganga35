#!/bin/sh -e
site=../site
sitelogs=../site/logs
content=content
logs=logs
headerA=../../inc/header-top.htm
headerB=../../inc/header-bottom.htm
sitenav=../../inc/nav.htm
rsstop=../inc/rss-top.xml
rssbottom=../inc/rss-bottom.xml
meta=meta.htm
name=name.txt
datestamp=date.txt
contentFile=content.htm
foot=../../inc/footer.htm
bottom=../../inc/html-bottom.htm
tally=0
logtally=0

rm -rf $site
mkdir -p $sitelogs


# List the index
#function setupindex {
#	echo "<h1>Full topic index</h1>" > index/content.htm;
#	for f in *; do
#		if [ $f != 'index' ]; then
#			echo "<a href='${f}.html'>${f}</a><br>" >> index/content.htm;
#		fi
#	done
#	echo "Index √"
#}

# List the log index
#function setuplogindex {
#	echo "" > index/content.htm;
#	for f in $(ls -d * | sort -r); do
#		if [ $f != 'index' ]; then
#			cd $f;
#			logtitle=$(cat $name);
#			cd ..
#			echo "<a href='${f}.html'>${logtitle}</a><br>" >> index/content.htm;
#		fi
#	done		
#	echo "Log Index √"
#}


# Setup topics
cd $content
setupindex;
for f in *; do
	cd $f;
	markup=''
	topPart=$(cat $headerA $meta $headerB);
	nav=$(cat $sitenav);
	contentText=$(cat $contentFile);
	footer=$(cat $foot);
	closefile=$(cat $bottom);
	mainContent="<main>${contentText}</main>";
	echo ${topPart}${nav}"${mainContent}"${footer}${closefile} > ../../$site/${f}.html
	cd ..
	tally=$((tally+1))
done
tally=$((tally-1))
echo "${tally} topics √"
cd ..
