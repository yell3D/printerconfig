#!/bin/bash

cd ~/printer_data/config
git pull origin master
git add .
current_date=$(date +"%Y-%m-%d %T")
git commit -m "Backup from $current_date"
git push origin master
