# 10D

This repository is the source for the [Ten Digits website](https://tendigits.space/). Feel free to clone this, strip out the content and use/modify the scripts for your own purposes.

## Scripts

Go into the `src` directory to run any of the following scripts.

### Create topics

This script will prompt you with questions and scaffold the folder and files for a topic into `src/content`. The text files generated are data sources, see "Topic files" below for formatting.

```
./topic.sh
```

### Process images

This script will look for source images in `src/img` and process for thumbnail and web output into `assets/img`

```
./img.sh
```

### Build site

This script will generate topic pages into the `site` folder based on whats found in `src/content`

```
./build.sh
```

## Topic files

The text files contain comma separated values. Avoid spaces after commas. Each text file should have an empty line at the end of the file.

* content.htm = main content html
* meta.htm = generated file with title and meta description html tags
* images.txt = [filename],[extension],[description]
* links.txt = [url],[description]
* log.txt = [date],[text]
* notes.txt = [note]

## RSS Feed

This is not auto-generated, instead it's a mix of handwritten notes and a log report of git commits to the site.

```
git log --since=1.month --pretty=format:"%cr | %B"
```
