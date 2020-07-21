#!/bin/bash

clear
# Start Running Link Check
cat "cfg/banner.txt"
printf "\n => Beginning Link Crawl... \n\n"

# Opening Variables
domains="cfg/domains.txt"
d=$(date +%F)
depth=3
mkdir -p crawl report crawl/$d-missinglink report/$d-missinglink

# Run Missing Link Script for Each URL in cfg/domains.txt
while IFS= read -r url
do
    name="${url/.*/}"
    target="https://$url"
    mkdir -p crawl/$d-missinglink/$name

    # Print main crawl
    printf "*** $name Log ***\n"
    printf "*** Crawling $name Links... ***"
    pylinkvalidate.py --verbose=0 -O -P --mode=process --workers=4 --report-type='errors' -d $depth -o crawl/$d-missinglink/$name/$name-links.txt $target
    printf "*** Crawling $name Images... ***"
    pylinkvalidate.py --verbose=0 -O -P --mode=process --workers=4 --report-type='errors' -d $depth -o crawl/$d-missinglink/$name/$name-images.txt --types=img $target
    printf "*** Crawling $name Meta Links... ***"
    pylinkvalidate.py --verbose=0 -O -P --mode=process --workers=4 --report-type='errors' -d $depth -o crawl/$d-missinglink/$name/$name-metalinks.txt --types=link $target
    printf "*** Crawling $name Scripts... ***"
    pylinkvalidate.py --verbose=0 -O -P --mode=process --workers=4 --report-type='errors' -d $depth -o crawl/$d-missinglink/$name/$name-scripts.txt --types=script $target

    printf "*** Generating Broken Link List... ***"
    printf "Broken Links for $name | $d\n\n" > report/$d-missinglink/$name-$d.txt
    printf "" >> report/$d-missinglink/$name-$d.txt
    grep '404' crawl/$d-missinglink/$name/$name-links.txt >> report/$d-missinglink/$name-$d.txt
    printf "" >> report/$d-missinglink/$name-$d.txt
    grep '404' crawl/$d-missinglink/$name/$name-images.txt >> report/$d-missinglink/$name-$d.txt

done < "$domains" > crawl/$d-missinglink/crawl-log-$d.txt

printf "\n => Link Validation Crawl Complete\n\n"