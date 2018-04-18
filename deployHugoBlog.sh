#!/bin/bash


cd /home/jhwang/works/jhwangSites
hugo
cd public
git add -A
msg="rebuilding site `date`"
if [ $# -eq 1 ]
	then msg="$1"
fi

git commit -m "$msg"

git push origin master --force
cd ..

