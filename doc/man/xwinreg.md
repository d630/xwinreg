xwinreg(1) -- organize X windows into regions and do tiling layouts.
=============================================================

## SYNOPSIS
 **xwinreg (-h|-v)**

 **xwinreg close [-T] -r**

 **xwinreg cycle [-T] [-w -r] -d (-j|-k|)**

 **xwinreg focus [-T] -r**

 **xwinreg focus-toggle [-T] -d**

 **xwinreg hide [-T] -r -A**

 **xwinreg -I [-C|-T|-n|-N|-a|-1|-2|-3|-4|-5|-6|-7|-8] (layout -A -e -g -G -r -x) ...**

 **xwinreg -I [-C|-T|-n|-N|-a|-1|-2|-3|-4|-5|-6|-7|-8] layout-abbrev ...**

 **xwinreg move-to-desk [-T] -r -D [-W]**

## REQUIREMENT
bc, GNU bash, GNU grep, GNU sed, wmctrl, X, xprop, xwininfo, xwinpp >= 0.1.1.0
## USE CASE
You use a stacking window manager like `openbox`(1), but sometimes you want to tile all windows without the mouse and arrange them in different "layouts".
## DESCRIPTION
`xwinreg`(1) is a bash shell script that acts like a stupid third party tiling application on Xorg. It lets you organize X windows into frames and regions and then to build your own layouts in a simple way. Therefore, `xwinreg`(1) uses `xwinpp`(1) to prepare a list of X window ids, and `wmctrl`(1) to interact with your EWMH/NetWM compatible X Window manager. See section **CONCEPTION** in this Manpage.

Strictly speaking, `xwinreg`(1) is a bash shell script, that wraps up following scripts (see also their Manpages, how to use them directly without `xwinreg`(1) as wrapper):
### xwinreg-calculate(1) - calculate frame geos.
Just as `xwinreg-id`(1), `xwinreg-calculate`(1) is required for layouting with `xwinreg-layout`(1). Its purpose is to set a frame relative to a workspace as scale base and to have base geometries; without that calculation `xwinreg-layout`(1) is not able to arrange regions and fill those with windows. All variables are written to a Temp File, and will then be processed in the course of layouting. You can here also determine the number of rows and columns for grid layouting or specify a Conf File with variables and frame aliases.

In the wrapper script `xwinreg`(1) you may not call the calculation directly; it will be called, before you build layouts with action `-l` and `-L`.

### xwinreg-close(1) - close regions gracefully.
`xwinreg-close`(1) reads variables inside a Tmp File and closes specified regions. After closing the Tmp File will be updated.

### xwinreg-cycle(1) - cycle order of regions or windows.
`xwinreg-cycle`(1) reads variables inside a Tmp File and prepares cycling of specified regions or windows. The modified variables will be written to the Tmp File. After that, `xwinreg-layout`(1) can perform its layouts with new geos and/or new order of x window ids.

### xwinreg-focus(1) - focus all windows in specified regions.
`xwinreg-focus`(1) reads variables inside a Tmp File and focuses windows in specified regions. Therefore, it switches to the desktop containing the windows, raises the windows, and gives them focus. At the end, the active window will be focused again. The Tmp File will not have an update.

### xwinreg-focus-toggle(1) - toggle focus on windows in all regions.
`xwinreg-focus-toggle`(1) reads a Tmp File with variables and changes the active window. After focusing, the Tmp file will be updated.

### xwinreg-hide(1) - add or remove window property 'hidden' in specified regions.
`xwinreg-hide`(1) reads variables in a Tmp File and modifies the hidden property of windows in specified regions. The Tmp File is not updated after this action.

### xwinreg-id(1) - get prepared X window ids from xwinpp(1).
Just as `xwinreg-calculate`(1), `xwinreg-id`(1) is required for layouting with `xwinreg-layout`(1). Its purpose is to read the ouput of `xwinpp`(1) and to create a Tmp File with its variables.

In the wrapper script `xwinreg`(1) you may not call `xwinreg-id`(1) directly; it will be called, if you use the option `-I` to indicate an Input File.

### xwinreg-layout(1) - build layouts inside arranged regions and fill them rule-based with windows.
After processing of `xwinreg-id`(1) and `xwinreg-calculate`(1), `xwinreg-layout`(1) reads their variables from a Tmp File and builds layouts in specified regions and fill them rule-based with windows. After layouting, the Tmp File will has been updated with new variables. Without layout-actions, `xwinreg-layout`(1) just reads the Tmp File and reruns the last documented layout.

All layouting takes place in only one frame. That one frame may have the geometry of the workspace or any other. To work with more than one frame, you need to create more than one Tmp File. See `xwinreg-calculate`(1).

### xwinreg-move-to-desk(1) - move windows of specified regions to another desktop.
`xwinreg-move-to-desk`(1) reads variables of a Tmp File and moves windows to a desktop. The Tmp File is not updated after that action.

## CONCEPTION
 `xwinpp`(1) reads a list with X window ids and does a preparing output with variables, which will be read by `xwinreg`(1). By using action `layout` or `layout-abbrev` a layout is generated and all specified windows will be ordered. In the course of layouting, a Tmp File with some variables is created. Any other actions then need to access that Tmp File to work properly. Only above layout actions must be used in combination with `xwinpp`(1); no windows to read are needed anymore.

 The layout is set only one workarea. Therefore, `xwinreg`(1) reads <_NET_WORKAREA> and determines a frame as scale base to have base geometry. In this frame `xwinreg`(1) arranges numbered regions, which are filled rule-based with the windows. Windows are taken in list-order; the first window is set as first window in the first region. You can determine, how many windows a region should have (minimum is one; maximum is the number of imported windows). The windows will be split and positioned with following actions: maximize, vertical, horizontal, grid-vertical, grid-horizontal, grid-square-vertical, grid-square-horizontal.

 In other words: all layouting takes place in one frame. That one frame may have the geometry of the workspace or any other. To work with more than one frame, you need to create more than one Tmp File. See sections **NOTES** and **CONFIGURATION** in this Manpage.
## OPTIONS
* `-a`, `--frame-alias=` <FRAMEALIAS>:
 Instead of options `-fx`, `-fy`, `-fw` and `-fh`, specify an alias. See section **CONFIGURATIONS** in this Manpage.

* `-C`, `--conf-file=` <FILE>:
 Read variables from <FILE>. See section **CONFIGURATIONS** in this Manpage.

* `-fh`, `--frame-height=` <PX>:
 Specify the <HEIGHT> of the frame.

* `-fw`, `--frame-width=` <PX>:
 Specify the <WIDTH> of the frame.

* `-fx`, `--frame-x=` <PX>:
 Specify the left edge of the frame.

* `-fy`, `--frame-y=` <PX>:
 Specify the top edge of the frame.

* `-h`, `--help`:
 Display a short help.

* `-I`, `--input-file=` <FILE>:
 Obtain output of `xwinpp`(1) from <FILE>. If <FILE> is a hyphen, get output from `xwinpp`(1) by reading from standard input.

* `-n`, `--number-of-rows=` <INT>:
 Specify number of rows for grid layouting.

* `-N`, `--number-of-cols=` <INT>:
 Specify number of columns for grid layouting.

* `-T`, `--tmp-file=` <FILE>:
 Before layouting, `xwinreg`(1) creates a Tmp File, whose variables are needed by all other actions to work with. With this option you can specify a nonregular file.

* `-v`, `--version`:
 Print current version of `xwinreg`(1).

* `-wh`, `--workarea-height=` <PX>:
 Specify the <HEIGHT> of the workarea.

* `-ww`, `--workarea-width=` <PX>:
 Specify the <WIDTH> of the workarea.

* `-wx`, `--workarea-x=` <PX>:
 Specify the left edge of the workarea.

* `-wy`, `--workarea-y=` <PX>:
 Specify the top edge of the workarea.

## SUBCOMNMANDS
### ACTIONS
* `-c`, `--close`:
 Close windows gracefully. Specify this action with option `-r`.

* `-f`, `--focus`:
 Switch to the desktop containing the windows, raise the windows, and give them focus. At the end, focus the active window again. Specify this action with option `-r`.

* `-H`, `--hide`:
 Add or remove window property hidden. Specify this action with option `-r` and `-A`.

* `-l`, `--layout`:
 Build layout and create Tmp File. Specify the layout with options `-r`, `-x`, `-A`, `-e`, `-G` and `-g`.

* `-L`, `--layout-abbrev` <REGN>,<WINN>,<LACT>,<LENT>:<GRAV>,<GEO>:
 Write action `-l` in shorthand.

* `-M`, `--move-to-desk`:
 Move windows to another desktop. Specify this action with options `-r`, `-D` and `-W`.

* `-o`, `--focus-toggle`:
 Tell `xwinreg`(1) to toggle focus on windows. Specify this action with option `-d`.

* `-y`, `--cycle`:
 Cycle order of regions or windows. Specify this action with options `-r`, `-d`, `-w`, `-j` and `-k`.

### OPTIONS
* `-A`, `--action=` ( <HACT> | <LACT> ):
 Used with actions `-l` and `-L` to tell `xwinreg`(1), how a region should be filled with windows. Used with action `-H` to specify hide action.

* `-d`, `--direction=` ( <ODIREC> | <YDIREC> ):
 Used with actions `-o` and `-y`.

* `-D`, `--desk=` <DESK>:
 Move windows to desktop <DESK>.

* `-e`, `--entity=` <LENT>:
 Specify the entity of actions `-l` and `-L`.

* `-g`, `--geo=` <GEO>:
 Specify the geometry of actions `-l` and `-L`.

* `-G`, `--gravity=` <GRAV>:
 Used with actions `-l` and `-L` to specify the gravity. If you are indecisive, use `0`.

* `-j`, `--join`:
 Used with action `-y` and options `-w` and `-r` with more than one region as argument (Example: `-r 1,3`). Cycling takes place between regions; without this option, windows are only cycled inside specific regions.

* `-k`, `--stack`:
 Used with action `-y` to keep region position, but cycle windows and <LACT>. Without this option region positions are cycled (together with windows and <LACT>).

* `-r`, `--region=` ( <REG> | <REGN> ):
 Select, which regions should be processed.

* `-w`, `--window`:
 Used with actions `-y` to indicate, that windows (not regions) should be processed.

* `-W`, `--switch`:
 Used with action `-M` to switch to the desktop after moving.

* `-x`, `--maximum=` <WINN>:
 Maximal number of windows a region should contain. Used with actions `-l` and `-L`.

## ARGUMENTS
* <DESK>:
 `curr` or relative to the current desktop `next` or `preview`. To specify a desktop number (starts at 0) use the prefix `i:`; a desktop name is prefixed with `s:`. Examples: `i:1`; `s:web`; `"s:some stuff"`.

* <FILE>:
 Regular file or named pipe.

* <FRAMEALIAS>:
 `northwest`, `north`, `northeast`, `east`, `southeast`, `south`, `southwest` or `west`. You can create your own aliases in a Conf File or overwrite those defaults.

* <GEO>:
 <X>: Pixel x size specified by an integer.
 <Y>: Pixel y size specified by an integer.
 <W>: Pixel width size specified by an integer.
 <H>: Pixel height size specified by an integer.
 <PRO>: Procent size specified by an integer.
 <REGALIAS>: `northwest`, `north`, `northeast`, `east`, `southeast`, `south`, `southwest` or `west`.
 Samples: "<REGALIAS>", "<PRO>,<PRO>,<PRO>,<PRO>", "<X>,<Y>,<W>,<H>".

* <GRAV>:
 `northwest`, `north`, `northeast`, `west`, `center`, `east`, `southwest`, `south`, `southeast` or `static`. Additional: `[0-10]`.

* <HACT>:
 `add` or `remove`.

* <INT>:
 Default is `2`.

* <LACT>:
 `maximize`, `horizontal`, `vertical`, `grid-horizontal`, `grid-vertical`, `grid-square-horizontal` or `grid-square-vertical`.

* <LENT>:
 `alias`, `px` or `pro`.

* <ODIREC>:
 `next` or `preview`.

* <PX>:
 Pixel size specified by an integer.

* <REG>:
 Up to this sample: `1` or `1,3` or `1-3` or `1,2-3`. Additional: `active` or `all`.

* <REGN>:
 Region number specified by an integer.

* <WINN>:
 Window number specified by an integer or `max`.

* <YDIREC>:
 `clock`, `anticlock` or `reverse`.

## EXAMPLES
### close
 xwinreg close -r active

 xwinreg close -T ${Home}/tmp/xwinreg.tmp -r 2

### cycle
 xwinreg cycle -w -r all -d clock

 xwinreg cycle -w -r active -d anticlock

 xwinreg cycle -w -r 1,3 -d clock

 xwinreg cycle -w -r 1,3 -d clock -j

 xwinreg cycle -d anticlock

 xwinreg cycle -k -d clock

### focus
 xwinreg focus -r active

 xwinreg focus -T ${Home}/tmp/xwinreg.tmp -r 2

### focus-toggle
 xwinreg -o -d preview

 xwinreg -o -T ${Home}/tmp/xwinreg.tmp -d next

### hide
 xwinreg hide -r active -A remove

 xwinreg hide -T ${Home}/tmp/xwinreg.tmp -r 2 -A add

### layout
 xwinpp -I ./list -P 0 -p | xwinreg -I - -L 1,max,horizontal,alias:0,all

 xwinpp -I ./list -P 0 -p | xwinreg -I - -T ${Home}/tmp/xwinreg.tmp -L 1,max,horizontal,alias:0,all

 xwinreg -I - -L 1,max,horizontal,alias:0,all < <(xwinpp -I ./list -P 0 -p)

 xwinreg -I <(xwinpp -I ./list -P 0 -p) -L 1,max,horizontal,alias:0,all

 xwinreg -I ./output-of-xwinpp -L 1,max,horizontal,alias:0,all

 xwinreg -I ./output-of-xwinpp -wx 0 -wy 0 -ww 1680 -wh 1049 -L 1,max,horizontal,alias:0,all

 xwinreg -I ./output-of-xwinpp -fw 0 -fh 0 -fx 840 -fy 524 -L 1,max,horizontal,alias:0,all

 xwinreg -I ./output-of-xwinpp -C ${Home}/.config/xwinreg/xwinreg.conf -L 1,max,horizontal,alias:0,all

 xwinreg -I ./output-of-xwinpp -C ${Home}/.config/xwinreg/xwinreg.conf -a new_frame_alias -L 1,max,horizontal,alias:0,all

 xwinreg -I ./output-of-xwinpp -L 1,max,grid-horizontal,alias:0,all

 xwinreg -I ./output-of-xwinpp -L 1,max,grid-square-horizontal,alias:0,all

 xwinreg -I ./output-of-xwinpp -n 4 -N 4 -L 1,max,grid-square-horizontal,alias:0,all

 xwinreg -I ./output-of-xwinpp -L 1,max,maximize,alias:0,all

 xwinreg -I ./output-of-xwinpp -L 1,1,maximize,alias:0,west -L 2,max,horizontal,alias:0,east

 xwinreg -I ./output-of-xwinpp -L 1,1,maximize,alias:0,west -L 2,1,maximize,alias:0,northeast -L 3,max,vertical,alias:0,southeast

### move-to-desk
 xwinreg -M -r active -D next -W

 xwinreg -M -r 2 -D curr

 xwinreg -M -r active -D i:1 -W

 xwinreg -M -r active -D s:internet -W

## NOTES
 If no workarea geometry is set, <_NET_WORKAREA> is used.

 Currently, window decoration is not considered.

 If no frame geometry is set, <_NET_WORKAREA> is used as frame. Every new frame needs its own Tmp File. In other words: all layouting takes place in one frame. You can specify another Tmp File with option `-T`, or you may create several Conf Files. See section **CONFIGURATIONS** in this Manpage.

 Options on command line overwrites variables in a Conf File.

 You can specify region aliases in a Conf File, which will be read by action `l` and `L` and written to a Tmp File. See section **CONFIGURATIONS** in this Manpage.

 If you use action `-l`, actually, the first option needs to be `-r`.

## CONFIGURATIONS
By default, `xwinreg`(1) needs no Conf File, because all important geometries will be calculated in the script. You can also use the relating options on command line. So, only use a Conf File, if you want to work with several frames (and several Tmp Files are needed) or if you need to set own aliases for frame and region geometries. Along with this programm comes an exemplary Conf File. Specify a Conf File with option `-C` or use <XWINREG_CONF_FILE>. You can set following parameters:

* enviroment variables:
 **XWINREG_TMP_FILE=<FILE>**; **XWINREG_INPUT_FILE=<FILE>**

* normal scalar variables:
 **workarea_x=<PX>**; **workarea_y=<PX>**; **workarea_width=<PX>**; **workarea_height=<PX>**; **frame_x=<PX>**; **frame_y=<PX>**; **frame_width=<PX>**; **frame_height=<PX>**; **row_number=<INT>**; **col_number=<INT>**

* associativ array variables:
 You can use it with above variables. You need to set them inside a function called `__xwr_xwinreg_calculate_calculating_frame_alias` respectively `__xwr_xwinreg_calculate_calculating_region_alias` and declare it with `declare -gA frames` respectively `declare -gA regions`: **frames[<ALIAS>]="<X> <Y> <W> <H>"**; **regions[<ALIAS>]="<X> <Y> <W> <H>"**
## ENVIROMENT
* <TMPDIR>:
 By default, Tmp File will be written as **TMPDIR/xwinreg_default.tmp**, otherwise as **/tmp/xwinreg_default.tmp**.

* <XWINREG_CONF_FILE>:
 Use this instead of option `-C`, if you want to use a Conf File.

* <XWINREG_INPUT_FILE>:
 Use this instead of option `-I`.

* <XWINREG_TMP_FILE>:
 Specify this instead default setting and instead using <XWINREG_TMP_FILE> in a Conf File.

## BUGS & REQUESTS
Report it on **https://github.com/D630/xwinreg/issues**
## TODO
See file **TODO**, which comes along with this programm.
## LICENSE
`xwinreg`(1) is licensed with GNU GPLv3. You should have received a copy of the GNU General Public License along with this program. If not, see for more details **http://www.gnu.org/licenses/gpl-3.0.html**.
## CHRONICLE
First version (0.1.0.0) was finished on: 2014-02-10.
## SEE ALSO
`bash`(1), `bc`(1), `grep`(1), `sed`(1), `wmctrl`(1), `x`(7), `xorg`(1), `xprop`(1), `xwininfo`(1), `xwinpp`(1), `xwinreg`(1), `xwinreg-calculate`(1), `xwinreg-close`(1), `xwinreg-cycle`(1), `xwinreg-focus`(1), `xwinreg-focus-toggle`(1), `xwinreg-hide`(1), `xwinreg-id`(1), `xwinreg-layout`(1), `xwinreg-move-to-desk`(1)
