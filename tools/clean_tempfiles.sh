#!/bin/bash

find ~/printer_data/logs/ -type f -mtime +1 -delete -print
find ~/printer_data/gcodes/ -type f -mtime +20 -delete -print

find ~/printer_data/config/ -name gcodes-*.zip -type f -delete -print
find ~/printer_data/config/ -name config-*.zip -type f -delete -print
find ~/printer_data/config/ -name printer-*.cfg -type f -mtime +10  -delete -print

find /tmp/scanner-calibrate-*.csv -type f -mtime +1  -delete -print
