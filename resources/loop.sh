#!/bin/sh

set -e

while [ 1 ]; do
    echo "Waiting $DELAY..."
    sleep $DELAY
    sh -c "/database_backup.sh $POSTGRES_USER $POSTGRES_PASSWORD \"$POSTGRES_DB\" $POSTGRES_HOST"
    sh -c "/delete_old_backups.sh $TOKEEP /backups"
done