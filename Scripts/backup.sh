#!/bin/bash

SOURCE_DIR="../Scripts"
DEST_DIR="../copy_scripts"
LOG_FILE="../copy_scripts/logs"
BACKUP_FILE="../copy_scripts/backup_report"
DATE=$(date "+%Y.%m.%d-%H:%M:%S")

mkdir -p $DEST_DIR

for dir in "$SOURCE_DIR" "$DEST_DIR"; do
    if [ ! -d "$dir" ]; then
        echo "Папка $dir не существует или не доступна" > $BACKUP_FILE
        exit 1
    fi
done

tar -zcvf $DEST_DIR/backup-$DATE.atr.gz $SOURCE_DIR > $LOG_FILE 2>&1

if [ $? -eq 0 ]; then
    echo "Резервное копирование завершено успешно" > $BACKUP_FILE
else
    echo "Во время резервного копирования произошла ошибка. Подробности в лог-файле." > $BACKUP_FILE
fi

