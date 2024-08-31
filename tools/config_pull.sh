#!/bin/bash


### Changes
# Feb 12, 2024
#   added auto banch name
# Jan 29, 2024 
#   created
###


config_folder=~/printer_data/config/printerconfig
branch=$(git branch -vv | grep -Po  "^[\s\*]*\K[^\s]*(?=.*$(git branch -rl '*/HEAD' | grep -o '[^ ]\+$'))")


cd $config_folder
git pull origin $branch --no-rebase

