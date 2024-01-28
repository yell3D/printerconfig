
PID_CALIBRATE HEATER=extruder TARGET=210
PID_CALIBRATE HEATER=heater_bed TARGET=60


https://klipperscreen.readthedocs.io/en/latest/Installation/

https://github.com/kyleisah/Klipper-Adaptive-Meshing-Purging


SET_KINEMATIC_POSITION X=60 Y=60 Z=5

_BED_MESH_CALIBRATE PROFILE=3x3 probe_count=3,3 mesh_min=20,40 mesh_max=220,230 samples_tolerance_retries=50

_BED_MESH_CALIBRATE PROFILE=19x19 probe_count=19,19 mesh_min=15,15 mesh_max=245,245 samples_tolerance_retries=50

# none CoreXY
SHAPER_CALIBRATE AXIS=Y
SHAPER_CALIBRATE AXIS=X


dfu flash
sudo dfu-util -a 0 -D ~/klipper/out/klipper.bin --dfuse-address 0x08002000:leave -d 0483:df11



#-------------------------#
#   CAN                   #
#-------------------------#

# query can  [-i can0] or [-f ~/klipper/out/klipper.bin] are defaults
python3 ~/katapult/scripts/flash_can.py -q


### VTCAT
##  Pico :  (usb can bridge)
##  EBB36: 0f31066bab9f
##  PitB : 

### Micron
##  Manta: 8ac34ee54870
##  EBB36: 75e72618a866


##  PitB : b1d44ac537b4 (broken ADC)



#-------------------------#
#   Klipper Update        #
#-------------------------#

# Pitb & ebb36
~/katapult/scripts/flash_can.py -u 62206b36544e


## SKR Pico  ############## ########################################################################
~/katapult/scripts/flash_can.py -u 6579fddfb1e6
#> makes error = OKAY! its just to put the pico in flash mode

ls /dev/serial/by-id
#> usb-katapult_rp2040_45503571290ABEA8-if00
~/katapult/scripts/flash_can.py -d /dev/serial/by-id/usb-katapult_rp2040_45503571290ABEA8-if00
###################################################################################################




#*# <---------------------- SAVE_CONFIG ---------------------->
#*# DO NOT EDIT THIS BLOCK OR BELOW. The contents are auto-generated.
#*#
#*# [heater_bed]
#*# control = pid
#*# pid_kp = 73.760
#*# pid_ki = 1.012
#*# pid_kd = 1344.272
#*#
#*# [extruder]
#*# control = pid
#*# pid_kp = 25.063
#*# pid_ki = 1.505
#*# pid_kd = 104.325
#*#
#*# [probe]
#*# z_offset = 13.420
#*#