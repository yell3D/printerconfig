find ~/printer_data/gcodes/ -type f -mtime +20 -delete
find ~/printer_data/config/gcodes-*.zip -type f -delete
find ~/printer_data/config/config-*.zip -type f -delete
find ~/printer_data/config/printer-*.cfg -type f -mtime +10 -delete

