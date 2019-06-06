#!/bin/sh

set -e

USERNAME=$1
PASSWORD=$2
DATABASES=$3
DBCOUNT=$(echo $DATABASES | wc -w)
HOST=$4

PREFIX=Postgresql_Backup_$4_
PERCORSO=/backups
NOW=$PREFIX$(date +%Y%m%d%H%M)

mkdir -p $PERCORSO/$NOW/

echo "------------ START BACKUP $NOW ------------"

export PGPASSWORD=$2
echo "($(date --date="now" "+%Y-%m-%d %H:%M")) Started"
echo "Backing up $DBCOUNT databases"
for DATABASE in $DATABASES; do
    echo "Backing up $DATABASE"
    pg_dump -Fp -h "$HOST" -U "$USERNAME" "$DATABASE" -f $PERCORSO/$NOW/$DATABASE.sql.in_progress;
    mv $PERCORSO/$NOW/$DATABASE.sql.in_progress $PERCORSO/$NOW/$DATABASE.sql
    gzip $PERCORSO/$NOW/$DATABASE.sql
done
echo "($(date --date="now" "+%Y-%m-%d %H:%M")) Done"

echo "------------ END BACKUP $NOW ------------"