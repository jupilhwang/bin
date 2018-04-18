#!/bin/bash
while [ ! -d "/var/run/media/jhwang/Disk1" ]; do sleep 1; done

#rsync -avz --stats --safe-links --dry-run --human-readable /home/jhwang/Files/Thunderbird /var/run/media/jhwang/Disk1 > /tmp/transfer.log
#cat /tmp/transfer.log | parallel --will-cite -j 5 rsync -azv --stats --relative --human-readable {} /var/run/media/jhwang/Disk1 > /tmp/transfer_result.log

rsync -azv /home/jhwang/Files/Thunderbird /var/run/media/jhwang/Disk1 > /tmp/transfer_result.log