#!/bin/sh -e
# Ten Digits image processing script, based on: https://git.sr.ht/~rostiger/nchrs/blob/main/src/batchVariants.sh
SRC="img"
DST="../assets/img"
HIGHRES=1628
MAXWIDTH=814
LOWWIDTH=407
COLORS=4

function resize () {
	
  # prevent an endless loop 
  [[ $file == *"${DST}/*"* ]] && continue 

  for file in $1; do
		[ -f "$file" ] || continue

		# create output path
		path=$(dirname $file)   # just/the/path    
		name=$(basename $file)  # filename.ext
		fileBase="${name%%.*}"  # filename
		fileExt="${name#*.}"    # ext
		dst="${path/$SRC/$DST}"    
		gifoutput="$dst/$fileBase.gif"
		webpoutput="$dst/$fileBase.webp"
		jpgoutput="$dst/$name"
		output="$dst/$name"
		highresoutput="$dst/$fileBase.highres.jpg"
		lowcolor="-colorspace gray -dither FloydSteinberg -colors 8 -depth 4"
		webp="-quality 85 -define webp:lossless=false"
		
		# existing images are skipped (delete images if they were updated)    
		# create the output path (and parents) if it doesn't exist
		if [[ ! -d "$dst" ]]; then 
			mkdir -p $dst
		fi
			
		# copy the file as is if it doesn't have the right extension
		if [[ "$fileExt" != "jpg" && "$fileExt" != "JPG" && "$fileExt" != "jpeg" && "$fileExt" != "png" && "$fileExt" != "DS_Store" ]]; then
			cp -r $file $dst
			printf "\nCOPIED ${file} AS IS\n"
			continue
		fi
		
		# Strip EXIF data and resize high res image
		
		if [[ "$fileExt" == "jpg" || "$fileExt" == "JPG" || "$fileExt" == "jpeg" || "$fileExt" == "png" ]]; then
			#get the width of the image
			width=$(identify -format "%w" "$file")> /dev/null
			if [[ ! -f $output ]]; then
		  		magick $file -strip -auto-orient -resize $LOWWIDTH $lowcolor $gifoutput
				magick $file -strip -auto-orient -resize $MAXWIDTH $webp $webpoutput
				magick $file -strip -auto-orient -resize $MAXWIDTH $jpgoutput
				magick $file -strip -auto-orient -resize $HIGHRES $highresoutput
		  		printf "${file}\n"
				continue
			else
				printf "."
			fi
		fi
  done
}

# find all file in the source folder and run resize() on each
find $SRC | while read file; do resize "${file}"; done
