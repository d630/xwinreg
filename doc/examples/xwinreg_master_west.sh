#!/usr/bin/env bash

get_xids.sh | xwinpp - -s visible -P 1 -p | xwinreg -I - -L 1,1,maximize,alias:0,west -L 2,max,horizontal,alias:0,east
#get_xids.sh | xwinpp - -s visible -P 1 -p | xwinreg -I - -L 1,1,maximize,alias:0,west -L 2,1,maximize,alias:0,northeast -L 3,max,horizontal,alias:0,southeast
#get_xids.sh | xwinpp - -s visible -P 1 -p | xwinreg -I - --layout-abbrev=1,1,maximize,alias:0,west --layout-abbrev=2,max,horizontal,alias:0,east
#get_xids.sh | xwinpp - -s visible -P 1 -p | xwinreg -I - --layout --region=1 --maximum=1 --action=maximize --entity=alias --gravity=0 --geo=west --layout --region=2 --maximum=max --action=horizontal --entity=alias --gravity=0 --geo=east
#get_xids.sh | xwinpp - -s visible -P 1 -p | xwinreg -F - -L 1,1,maximize,alias:0,west -L 2,1,maximize,alias:0,northeast -L 3,max,vertical,alias:0,southeast
