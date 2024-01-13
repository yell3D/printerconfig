
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


#-------------------------#
#   Katapult              #
#-------------------------#
# [-i can0] or [-f ~/klipper/out/klipper.bin] are defaults

# query can
python3 ~/katapult/scripts/flash_can.py -q


# Update SKR PICO UART
# Press the SKR Pico reset button twice to enter the Canoot bootloader.
python3 ~/katapult/scripts/flash_can.py -d /dev/ttyAMA0


### RP2040
# Update klipper
python3 ~/katapult/scripts/flashtool.py -u 75e72618a866 -r 

#install
python3 ~/katapult/scripts/flash_can.py -i can0 -f ~/klipper/out/klipper.bin -u 75e72618a866


### VTCAT
##  Pico :  (usb can bridge)
##  EBB36: 0f31066bab9f
##  PitB : 

### Micron
##  Manta: 8ac34ee54870
##  EBB36: 75e72618a866

##  PitB : b1d44ac537b4 (broken ADC)

# Katapult  build deployer & flash
python3 ~/katapult/scripts/flashtool.py -u b1d44ac537b4 -f ~/katapult/out/deployer.bin





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
