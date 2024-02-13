#!/bin/bash

# source: https://bigtreetech.github.io/docs/libinput_calibration.html#convert-to-libinput

#according to https://wiki.archlinux.org/title/Talk:Calibrating_Touchscreen#Libinput%5Fbreaks%5Fxinput%5Fcalibrator

screen_width=$1
screen_height=$2
click_0_X=$3
click_0_Y=$4
click_3_X=$5
click_3_Y=$6

re='^[0-9]+$'
if ! [[ $screen_width =~ $re ]] ; then
  echo "error: screen_width=\"$screen_width\" Not a number" >&2; exit 1
fi
if ! [[ $screen_height =~ $re ]] ; then
  echo "error: screen_height=\"$screen_height\" Not a number" >&2; exit 1
fi
if ! [[ $click_0_X =~ $re ]] ; then
  echo "error: click_0_X=\"$click_0_X\" Not a number" >&2; exit 1
fi
if ! [[ $click_0_Y =~ $re ]] ; then
  echo "error: click_0_Y=\"$click_0_Y\" Not a number" >&2; exit 1
fi
if ! [[ $click_3_X =~ $re ]] ; then
  echo "error: click_3_X=\"$click_3_X\" Not a number" >&2; exit 1
fi
if ! [[ $click_3_Y =~ $re ]] ; then
  echo "error: click_3_Y=\"$click_3_Y\" Not a number" >&2; exit 1
fi

#a = (screen_width * 6 / 8) / (click_3_X - click_0_X)
#c = ((screen_width / 8) - (a * click_0_X)) / screen_width
#e = (screen_height * 6 / 8) / (click_3_Y - click_0_Y)
#f = ((screen_height / 8) - (e * click_0_Y)) / screen_height

a=$(awk "BEGIN { printf(\"%.6f\", ($screen_width * 6 / 8) / ($click_3_X - $click_0_X))}")
c=$(awk "BEGIN { printf(\"%.6f\", (($screen_width / 8) - ($a * $click_0_X)) / $screen_width)}")
e=$(awk "BEGIN { printf(\"%.6f\", ($screen_height * 6 / 8) / ($click_3_Y - $click_0_Y))}")
f=$(awk "BEGIN { printf(\"%.6f\", (($screen_height / 8) - ($e * $click_0_Y)) / $screen_height)}")

CONFIG_OPTION="Option \"CalibrationMatrix\" "
CONFIG_LINE="\"$a 0.000000 $c 0.000000 $e $f 0.000000 0.000000 1.000000\""

echo "${CONFIG_OPTION}${CONFIG_LINE}"
echo ""

CONFIG_OPTION="Option \"CalibrationMatrix\" "
CONFIG="/usr/share/X11/xorg.conf.d/40-libinput.conf"
INPUT_CLASS="Identifier \"libinput touchscreen catchall\""
if [ -e "${CONFIG}" ]; then
    ks_restart=0
    grep -e "^\        ${CONFIG_OPTION}${CONFIG_LINE}" ${CONFIG} > /dev/null
    STATUS=$?
    if [ $STATUS -eq 1 ]; then
        sudo sed -i "/${CONFIG_OPTION}/d" ${CONFIG}
        sudo sed -i "/${INPUT_CLASS}/a\        ${CONFIG_OPTION}${CONFIG_LINE}" ${CONFIG}
        echo "Written to file:"
        echo "    ${CONFIG}"
        echo ""
        ks_restart=1
    fi

    # restart KlipperScreen
    if [ ${ks_restart} -eq 1 ];then
        sudo service KlipperScreen restart
    fi

    echo "run:"
    echo "    DISPLAY=:0 xinput list-props <device>"
    echo "to check if the calibration parameters are effective"
    echo ""
fi
