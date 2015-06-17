#!/bin/bash

APP_NAME="app name"
DB_NAME="db-name"
MONGO_HOST="localhost"
MONGO_PORT="27017"
BACKUP_DIR="/Users/nauval/mongobackup-$APP_NAME"
MONGODUMP=`which mongodump`
TIMESTAMPT=`date +%F-%H%M`
BACKUP_FILE="$APP_NAME-$TIMESTAMPT"

#Force file syncronization and lock writes
mongo admin --eval "printjson(db.fsyncLock())"

$MONGODUMP -h $MONGO_HOST:$MONGO_PORT -d $DB_NAME

mongo admin --eval "printjson(db.fsyncUnlock())"

mkdir $BACKUP_DIR 2> /dev/null
mv dump $BACKUP_FILE 
tar czf $BACKUP_DIR/$BACKUP_FILE.tar.gz $BACKUP_FILE 2> /dev/null
rm -rf $BACKUP_FILE