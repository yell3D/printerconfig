#!/bin/bash
#  Initial Version from https://github.com/EricZimmerman/VoronTools/blob/main/autocommit.sh

loc_config=~/printer_data/config/printerconfig
loc_klipper=~/klipper

loc_moonraker=~/moonraker

loc_mainsail=~/mainsail

loc_fluidd=~/fluidd

branch=$(git -C $loc_config branch -vv | grep -Po  "^[\s\*]*\K[^\s]*(?=.*$(git -C $loc_config  branch -rl '*/HEAD' | grep -o '[^ ]\+$'))")

grab_version(){
  if [ -d "$loc_klipper" ]; then
    klipper_commit=$(git -C $loc_klipper describe --always --tags --long | awk '{gsub(/^ +| +$/,"")} {print $0}')
    m1="Klipper version: $klipper_commit"
  fi
  if [ -d "$loc_moonraker" ]; then
    moonraker_commit=$(git -C $loc_moonraker describe --always --tags --long | awk '{gsub(/^ +| +$/,"")} {print $0}')
    m2="Moonraker version: $moonraker_commit"
  fi
  if [ -f "$loc_mainsail/.version" ]; then
    mainsail_ver=$(head -n 1 $loc_mainsail/.version)
    m3="Mainsail version: $mainsail_ver"
  fi
  if [ -f "$loc_fluidd/version" ]; then
    fluidd_ver=$(head -n 1 $loc_fluidd/.version)
    m4="Fluidd version: $fluidd_ver"
  fi
}

push_config(){
  cd $loc_config
  git pull origin $branch --no-rebase
  git add .
  current_date=$(date +"%Y-%m-%d %T")
  git commit -m "Autocommit from $current_date" -m "$m1" -m "$m2" -m "$m3" -m "$m4"
  git push origin $branch
}

grab_version
push_config
