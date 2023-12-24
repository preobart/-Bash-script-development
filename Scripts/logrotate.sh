#!/bin/bash

log_file='./logs'
date=$(date "+%Y.%m.%d-%H:%M:%S")
logs_size=$(wc -c $log_file | grep -o [0-9]*)

if [ "$logs_size" -gt "2" ]; then
  cp $log_file ./logs-"$date"
  gzip ./logs-"$date"
  > $log_file
  
  while [ $(ls logs-* | wc -l) -gt "5" ]; do
    del_file=$(ls logs-* | sort | head -n 1)
    rm $del_file
  done
fi	
