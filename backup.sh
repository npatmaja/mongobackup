#!/bin/bash

APP_NAME="APP_NAME"
DB_NAME="DB_NAME"
MONGO_HOST="localhost"
MONGO_PORT="27017"
BACKUP_DIR="/home/username/mongobackup-$APP_NAME"
MONGODUMP=`which mongodump`
TIMESTAMPT=`date +%F-%H%M`
BACKUP_FILE="$APP_NAME-$TIMESTAMPT"

#Force file syncronization and lock writes
# mongo admin --eval "printjson(db.fsyncLock())"

$MONGODUMP -h $MONGO_HOST:$MONGO_PORT -d $DB_NAME

# mongo admin --eval "printjson(db.fsyncUnlock())"

mkdir $BACKUP_DIR
mv dump $BACKUP_FILE
tar czf $BACKUP_DIR/$BACKUP_FILE.tar.gz $BACKUP_FILE
rm -rf $BACKUP_FILE