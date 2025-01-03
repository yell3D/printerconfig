#!/bin/bash


config_folder=~/printer_data/config/printerconfig
cd $config_folder

branch=$(git branch -vv | grep -Po  "^[\s\*]*\K[^\s]*(?=.*$(git branch -rl '*/HEAD' | grep -o '[^ ]\+$'))")

git pull origin $branch --no-rebase

