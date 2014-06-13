#!/usr/bin/env bash

get_xids.sh | xwinpp - -s visible -P 1 -p | xwinreg -I - -L 1,max,grid-square-horizontal,alias:0,all
