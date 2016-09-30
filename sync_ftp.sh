#!/bin/bash

USER="admin"
TARGETFOLDER="/tmp/mnt/sda3"
SOURCEFOLDER="/home/jhwang/HomeRouter"

#lftp -f "
#open $HOST 
#user $USER $PASS 
#lcd $SOURCEFOLDER
#mirror -c -e --reverse --verbose $SOURCEFOLDER $TARGETFOLDER
#bye
#"

unison $SOURCEFOLDER ssh://admin@jupilhwang.asuscomm.com/tmp/mnt/sda3 -batch #> /dev/null 2>&1
