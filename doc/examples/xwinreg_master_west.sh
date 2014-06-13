#!/usr/bin/env bash

get_xids.sh | xwinpp - -s visible -P 1 -p | xwinreg -I - -L 1,1,maximize,alias:0,west -L 2,max,horizontal,alias:0,east
