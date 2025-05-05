#!/bin/bash
echo "Trying to publish all changes to archive.petau.net"
echo "Getting HTML from Logseq"

cd ~/thesis/logseq || exit
logseq-publish-spa ~/thesis/docs/ --theme-mode dark --accent-color orange --static-directory ~/logseq/static

echo "Publishing to archive.petau.net"
cd ~/thesis || exit
git add .
git commit -m "CI: Publish to archive.petau.net"
git push
echo "Publish Complete"
exit 0