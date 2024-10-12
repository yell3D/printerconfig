#!/bin/bash

sed -i 's\TRSYNC_TIMEOUT = 0.025\TRSYNC_TIMEOUT = 0.05\g' ~/klipper/klippy/mcu.py
sed -i 's\BIT_MAX_TIME=.000004\BIT_MAX_TIME=.000030\g' ~/klipper/klippy/extras/neopixel.py
