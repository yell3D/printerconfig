#!/bin/bash


### Changes
# Aug 28, 2024
#  Updates from EricZimmerman 
# Feb 12, 2024
#  added auto banch name
# Sep 10, 2023 
#  removed legacy token notes
#  marked script with filemod +x
#  renamed default branch
# Jul 24, 2023 
#  Initial Version from https://github.com/EricZimmerman/VoronTools/blob/main/autocommit.sh
###

#####################################################################
### Please set the paths accordingly. In case you don't have all  ###
### the listed folders, just keep that line commented out.        ###
#####################################################################

### Path to your config folder you want to backup
config_folder=~/printer_data/config/printerconfig

### Path to your Klipper folder, by default that is '~/klipper'
klipper_folder=~/klipper

### Path to your Moonraker folder, by default that is '~/moonraker'
moonraker_folder=~/moonraker

### Path to your Mainsail folder, by default that is '~/mainsail'
mainsail_folder=~/mainsail

### Path to your Fluidd folder, by default that is '~/fluidd'
fluidd_folder=~/fluidd

### The branch of the repository that you want to save your config
branch=$(git -C $config_folder branch -vv | grep -Po  "^[\s\*]*\K[^\s]*(?=.*$(git -C $config_folder  branch -rl '*/HEAD' | grep -o '[^ ]\+$'))")

#####################################################################
################ !!! DO NOT EDIT BELOW THIS LINE !!! ################
#####################################################################
grab_version(){
  if [ ! -z "$klipper_folder" ]; then
    klipper_commit=$(git -C $klipper_folder describe --always --tags --long | awk '{gsub(/^ +| +$/,"")} {print $0}')
    m1="Klipper version: $klipper_commit"
  fi
  if [ ! -z "$moonraker_folder" ]; then
    moonraker_commit=$(git -C $moonraker_folder describe --always --tags --long | awk '{gsub(/^ +| +$/,"")} {print $0}')
    m2="Moonraker version: $moonraker_commit"
  fi
  if [ ! -z "$mainsail_folder" ]; then
    mainsail_ver=$(head -n 1 $mainsail_folder/.version)
    m3="Mainsail version: $mainsail_ver"
  fi
  if [ ! -z "$fluidd_folder" ]; then
    fluidd_ver=$(head -n 1 $fluidd_folder/.version)
    m4="Fluidd version: $fluidd_ver"
  fi
}

push_config(){
  cd $config_folder
  git pull origin $branch --no-rebase
  git add .
  current_date=$(date +"%Y-%m-%d %T")
  git commit -m "Autocommit from $current_date" -m "$m1" -m "$m2" -m "$m3" -m "$m4"
  git push origin $branch
}

grab_version
push_config
