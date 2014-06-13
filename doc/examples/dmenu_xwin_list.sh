#!/usr/bin/env bash

wmctrl -i -a "$(wmctrl -lGpx | dmenu -i -b -p "FOCUS" -l 10 -nf "#DCDCCC" -nb "#2C2C2C" -sf "#2C2C2C" -sb "#DCDCCC" -fn "'Droid Sans Mono-12'" | awk '{print $1}')"
