#!/bin/bash
find ~/printer_data/gcodes/ -type f -mtime +20 -delete -print
find ~/printer_data/config/ -name gcodes-*.zip -type f -delete -print
find ~/printer_data/config/ -name config-*.zip -type f -delete -print
find ~/printer_data/config/ -name printer-*.cfg -type f -mtime +10  -print
