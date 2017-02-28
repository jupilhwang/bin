#!/bin/bash
username=$(whoami)

function check_app {
    proc="$(ps aux | grep $username | grep -v $0 | grep $1 | grep -v grep)"
    if [ "$proc" != "" ]
    then
        echo "!!! Shutdown $1 first!"
        exit 1
    fi
}

function vacuum_mozillas {
    echo "Vacuuming $1..."
for db in $2/*/*.sqlite; do
echo 'processing $db'
sqlite3 $db << EOF
.echo on
vacuum;
reindex;
analyze;
.exit
EOF
done
#    find $2 -type f -name '*.sqlite' -exec sqlite3 -line {} VACUUM;reindex;analyze \;
}

check_app firefox
check_app thunderbird
vacuum_mozillas firefox ~/.mozilla/firefox
vacuum_mozillas thunderbird ~/.thunderbird
