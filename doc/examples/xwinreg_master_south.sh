#!/usr/bin/env bash
get_xids.sh | xwinpp - -s visible -P 1 -p | xwinreg -I - -L 1,1,maximize,alias:0,south -L 2,max,vertical,alias:0,north
