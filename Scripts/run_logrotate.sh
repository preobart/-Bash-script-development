#!/bin/bash
fswatch -o ~/Desktop/Scripts/logs | xargs -I{} ~/Desktop/Scripts/logrotate.sh & 

