#!/bin/bash

date=$(date "+%Y.%m.%d %H:%M:%S")
log_file='./report'

check_count_line () {
  while [ $(wc -l $log_file | grep -o "[0-9]*") -gt "5" ]; do
    sed -i '1d' $log_file
  done
}

check_host() {
  host=$1
  ping -c 1 "$host" > /dev/null
  if [ $? -eq 0 ]; then
    echo "Дата: $date Состояние: хост $host доступен" >> $log_file
  else
    echo "Дата: $date Состояние: хост $host недоступен" >> $log_file
  fi
  check_count_line
}

check_port() {
  host=$1
  port=$2
  nc -z -v -w5 "$host" "$port" > /dev/null 2>&1
  if [ $? -eq 0 ]; then
    echo "Дата: $date Состояние: порт $port на хосте $host доступен" >> $log_file
  else
    echo "Дата: $date Состояние: порт $port на хосте $host недоступен" >> $log_file
  fi
  check_count_line
}

check_port google.com 80
check_host example.com
check_host yandex.com
