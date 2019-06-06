#!/bin/sh

set -e

TOKEEP=$1
FOLDER=$2
NOW=$(date +%Y%m%d%H%M)

echo "------------ START CLEAN OLD BACKUPS $NOW ------------"

# http://stackoverflow.com/questions/2960022/shell-script-to-count-files-then-remove-oldest-files#2961817
SEDCMD="1,$(echo $TOKEEP)d"
TODELETE=$(ls -t -1 $FOLDER | sed -e "$SEDCMD")
TODELETECOUNT=$(ls -t -1 $FOLDER | sed -e "$SEDCMD" | wc -l)

if [ -z $TODELETE ]; then
    echo "No backups to delete."
else
    echo "Deleting all backups except last $TOKEEP"

    cd $FOLDER
    ls -t -1 | sed -e "$SEDCMD" | xargs -d '\n' rm -r
fi

echo "------------ END CLEAN OLD BACKUP $NOW ------------"