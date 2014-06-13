# xwinreg v0.2.0.0 [GNU GPLv3] #

`xwinreg`(1) is a bash shell script, that acts like a stupid third party tiling
application on `Xorg`(1). It lets you organize X windows into frames and regions
and then to build your own layouts in a simple way. Therefore, `xwinreg`(1) uses
`xwinpp`(1) to prepare a list of X window ids, and `wmctrl`(1) to interact with
your EWMH/NetWM compatible X Window manager.

Strictly speaking, `xwinreg`(1) is a bash shell script, that wraps up following
scripts (see also their Manpages, how to use them directly without `xwinreg`(1)
as wrapper):

* `xwinreg-calculate`(1) - calculate frame geos.
* `xwinreg-close`(1) - close regions gracefully.
* `xwinreg-cycle`(1) - cycle order of regions or windows.
* `xwinreg-focus`(1) - focus all windows in specified regions.
* `xwinreg-focus-toggle`(1) - toggle focus on windows in all regions.
* `xwinreg-hide`(1) - add or remove window property 'hidden' in specified
  regions.
* `xwinreg-id`(1) - get prepared X window ids from `xwinpp`(1).
* `xwinreg-layout`(1) - build layouts inside arranged regions and fill them
  rule-based with windows.
* `xwinreg-move-to-desk`(1) - move windows of specified regions to another
  desktop.

There are [many](https://en.wikipedia.org/wiki/Tiling_window_manager) tiling
window managers and third party applications for the X Window System. Only use
`xwinreg`(1), if you have a stacking window manager like `openbox`(1), but
sometimes you want to tile all windows without the mouse and arrange them in
different "layouts". Do not use it, if you do not like to do things in
`bash`(1): `bash`(1) is relative slow (and there are well known other reasons).
I chose it, because I am a kind of newbie. Anyway, most people can understand
its code and `xwinreg`(1) does not need to process much data; it is still going
faster than the blink of my slow eyes. So, for me it is still usefull.

## Install ##

Required: bc, GNU bash, GNU grep, GNU sed, wmctrl, Xorg, xprop, xwininfo,
[xwinpp](https://github.com/D630/xwinpp)

* Get `xwinreg`(1) with `git clone https://github.com/D630/xwinreg.git` or
  download it on https://github.com/D630/xwinreg/releases
* Copy the scripts in xwinreg/bin elsewhere into `<PATH>` and the manpages in
  xwinreg/doc/man/*.1 into `$MANPATH`. Or do the following:
        ```bash
        $ cd -- ./xwinreg
        $ sudo install -m 755 -D ./bin/* /usr/local/bin/
        $ sudo for i in ./doc/man/*.1 ; do gzip -c "$i" > /usr/share/man/man1/${i##*/}.gz ; done
        ```

## Usage ##

```bash
xwinreg
        [-I]
        [-C|-T|-n|-N|-a|-fx|-fy|-fw|-fh|-wx|-wy|-ww|-wh]
        (-c|-f|-H|-h|[-l ...|-L ...]|-M|-v|-y)

OPTIONS
-------
    OPT                             ARG
    ---                             ---
    -a,  --frame-alias=             <FRAMEALIAS>
    -C,  --conf-file=               <FILE>
    -fh, --frame-height=            <PX>
    -fw, --frame-width=             <PX>
    -fx, --frame-x=                 <PX>
    -fy, --frame-y=                 <PX>
    -h,  --help
    -I,  --input-file=              <FILE> or hyphen (-)
    -N,  --number-of-cols=          <INT>
    -n,  --number-of-rows=          <INT>
    -T,  --tmp-file=                <FILE>
    -v,  --version
    -wh, --workarea-height=         <PX>
    -ww, --workarea-width=          <PX>
    -wx, --workarea-x=              <PX>
    -wy, --workarea-y=              <PX>

SUBCOMMANDS
-----------
    ACTION                          REQUIRED
    ------                          --------
    -c,  --close                    <REG>
    -f,  --focus                    <REG>
    -H,  --hide                     <REG> <HACT>
    -l,  --layout                   <REGN> <WINN> <LACT> <LENT> <GRAV>
                                    <GEO>
    -M,  --move-to-desk             <REG> <DESK> -W
    -o,  --focus-toggle             <ODIREC>
    -y,  --cycle                    <REG> <YDIREC> -w -k -j

    ACTION                          ARG
    ------                          ---
    -L,  --layout-abbrev=           <REGN>,<WINN>,<LACT>,<LENT>:<GRAV>,
                                    <GEO>

    OPT                             ARG
    ---                             ---
    -A,  --action=                  ( <HACT> | <LACT> )
    -D,  --desk=                    <DESK>
    -d,  --direction=               ( <ODIREC> | <YDIREC>  )
    -e,  --entity=                  <LENT>
    -g,  --geo=                     <GEO>
    -G,  --gravity=                 <GRAV>
    -j,  --join
    -k,  --stack
    -r,  --region=                  ( <REG> | <REGN> )
    -W,  --switch
    -w,  --window
    -x,  --maximum=                 <WINN>

ARGUMENTS
---------
    <DESK>          'curr' or relative to the current desktop 'next' or
                    'preview'. To specify a desktop number (starts at 0)
                    use the prefix 'i:'; a desktop name is prefixed with
                    's:'. Examples: 'i:1'; 's:web'; '"s:some stuff"'.
    <FILE>          Regular file or named pipe.
    <FRAMEALIAS>    'northwest', 'north', 'northeast', 'east',
                    'southeast', 'south', 'southwest' or 'west'.
    <GEO>
                    <X>        Pixel x size specified by an integer.
                    <Y>        Pixel y size specified by an integer.
                    <W>        Pixel width size specified by an integer.
                    <H>        Pixel height size specified by an integer.
                    <PRO>      Procent size specified by an integer.
                    <REGALIAS> 'northwest', 'north', 'northeast','east',
                               'southeast', 'south', 'southwest' or
                               'west'.
                    Samples:
                               '<REGALIAS>',
                               '<PRO>,<PRO>,<PRO>,<PRO>',
                               '<X>,<Y>,<W>,<H>'.
    <GRAV>          'northwest', 'north', 'northeast', 'west', 'center',
                    'east', 'southwest', 'south', 'southeast' or
                    'static'. Additional: '[0-10]'.
    <HACT>          'add' or 'remove'.
    <INT>           Default is '2'.
    <LACT>          'maximize', 'horizontal', 'vertical',
                    'grid-horizontal', 'grid-vertical',
                    'grid-square-horizontal' or 'grid-square-vertical'.
    <LENT>          'alias', 'px' or 'pro'.
    <ODIREC>        'next' or 'preview'.
    <PX>            Pixel size specified by an integer.
    <REF>           'window', 'region' or 'frame'.
    <REG>           Up to this sample: '1', '1,3', '1-3' or '1,2-3'.
                    Additional: 'active' or 'all'.
    <REGN>          Region number specified by an integer.
    <WINN>          Window number specified by an integer or 'max'.
    <YDIREC>        'clock', 'anticlock' or 'reverse'.
```

## Examples ##

The things behind the following are documented in the Manpages of the wrapper
and the subscripts.

Lets say, we have this situation:

```bash
$ Xorg -version

X.Org X Server 1.15.1
[...]
X Protocol Version 11, Revision 0
Build Operating System: Linux 3.2.0-37-generic x86_64 Ubuntu
[...]
xorg-server 2:1.15.1-0ubuntu2 (For technical support please see http://www.ubuntu.com/support)
[...]
```

```bash
$ openbox --version
Openbox 3.5.2
Copyright (c) 2004   Mikael Magnusson
Copyright (c) 2002   Dana Jansens

This program comes with ABSOLUTELY NO WARRANTY.
This is free software, and you are welcome to redistribute it
under certain conditions. See the file COPYING for details.
```

We have two screens, two desktops and current desktop is "0":

```bash
$ echo $DISPLAY ; printf '%*s\n' "$(tput cols)" ' ' | tr ' ' . ; xrandr ; printf
'%*s\n' "$(tput cols)" ' ' | tr ' ' . ; xprop -root -notype | egrep -e
'^_NET_(NUMBER_OF_DESKTOPS|DESKTOP_NAMES|CURRENT_DESKTOP|WORKAREA)'
:0.0
................................................................................
Screen 0: minimum 320 x 200, current 1680 x 1050, maximum 32767 x 32767
LVDS1 connected (normal left inverted right x axis y axis)
   1280x800       60.0 +
   1024x768       60.0
   800x600        60.3     56.2
   640x480        59.9
VGA1 connected 1680x1050+0+0 (normal left inverted right x axis y axis) 474mm x 296mm
   1680x1050      59.9*+   60.0
   1280x1024      75.0     60.0
   1440x900       75.0     59.9
   1280x960       60.0
   1152x864       75.0
   1024x768       75.1     60.0
   832x624        74.6
   800x600        75.0     60.3     56.2
   640x480        75.0     60.0
   720x400        70.1
DVI1 disconnected (normal left inverted right x axis y axis)
TV1 disconnected (normal left inverted right x axis y axis)
VIRTUAL1 disconnected (normal left inverted right x axis y axis)
.....................................................................................
_NET_CURRENT_DESKTOP = 0
_NET_DESKTOP_NAMES = "null", "eins"
_NET_WORKAREA = 0, 1, 1680, 1049, 0, 1, 1680, 1049
_NET_NUMBER_OF_DESKTOPS = 2
```

On desktop "0" we have five visible and maximized X windows with no decorations:

```bash
$ __get_win_xids() { read -r _ _ _ _ xids < <(xprop -root _NET_CLIENT_LIST) &&
printf '%s\n' ${xids//,/} ; } ; __get_win_xids ; printf '%*s\n' "$(tput cols)" '
' | tr ' ' . ; wmctrl -lxG ; printf '%*s\n' "$(tput cols)" ' ' | tr ' ' . ;
__get_win_xids | xwinpp - -s visible -P 1 -p
0x32000a3
0x2000022
0x2200022
0x2400022
0x2800022
....................................................................................
0x032000a3  0 0    1    1680 1049 emacs24-x.Emacs24     ICH2 ~/code/source/xwinreg/README.md
0x02000022  0 0    1    1680 1049 xterm.XTerm           ICH2 xterm
0x02200022  0 0    1    1680 1049 xterm.XTerm           ICH2 xterm
0x02400022  0 0    1    1680 1049 xterm.XTerm           ICH2 xterm
0x02800022  0 0    1    1680 1049 xterm.XTerm           ICH2 xterm
.............................................................................................
desk_curr=0
desk_select=( 0 )
win_active=0x2000022
win_active_geo_x_y=( 0,1 )
win_active_geo_w_h=( 1680,1049 )
win_active_frame_extents=0,0,0,0
win_active_tags=
win_xid=( 0x2000022 0x32000a3 0x2200022 0x2400022 0x2800022 )
win_number=5
win_geo_x_y=( 0,1 0,1 0,1 0,1 0,1 )
win_geo_w_h=( 1680,1049 1680,1049 1680,1049 1680,1049 1680,1049 )
win_frame_extents=( 0,0,0,0 0,0,0,0 0,0,0,0 0,0,0,0 0,0,0,0 )
win_tags=(  )
```

Now we want to arrange these windows in a layout, for example in a layout, which
we can call "master left". Therefore, we build a frame with the size of the
workspace on the current desktop (desktop "0"); and that frame should be split
into two regions with same width and height, but different x and y position. To
do this, there are two ways. The method with the wrapper `xwinreg`(1) could be
one of these lines:

```bash
$ __get_win_xids | xwinpp - -s visible -P 1 -p | xwinreg -I - --layout --region=1
--maximum=1 --action=maximize --entity=alias --gravity=0 --geo=west --layout
--region=2 --maximum=max --action=horizontal --entity=alias --gravity=0
--geo=east
$ __get_win_xids | xwinpp - -s visible -P 1 -p | xwinreg -I - -l -r 1 -x 1 -A
maximize -e alias -G 0 -g west -l -r 2 -x max -A horizontal -e alias -G 0 -g
east
$ __get_win_xids | xwinpp - -s visible -P 1 -p | xwinreg -I -
--layout-abbrev=1,1,maximize,alias:0,west
--layout-abbrev=2,max,horizontal,alias:0,east
$ __get_win_xids | xwinpp - -s visible -P 1 -p | xwinreg -I - -L
1,1,maximize,alias:0,west -L 2,max,horizontal,alias:0,east
```

To use the same layout with the subscripts `xwinreg-id`(1),
`xwinreg-calculate`(1) and `xwinreg-layout` (last with layout-abbrev) directly:

```bash
$ __get_win_xids | xwinpp - -s visible -P 1 -p | xwinreg-id -I -
$ xwinreg-calculate
$ xwinreg-layout -L 1,1,maximize,alias:0,west -L 2,max,horizontal,alias:0,east
```

Once, a layout is set and a Tmp File is created, we can work with them. Quite
usefull is window cycling:

To cycle clockwisely all windows between all regions:

```bash
$ xwinreg cycle -w -r all -d clock
```

To cycle clockwisely all regions:

```bash
$ xwinreg cycle -d clock -k
```

If we arrange three regions and fill them up with windows, we could also do
cycling like this:

```bash
$ __get_win_xids | xwinpp - -s visible -P 1 -p | xwinreg -I - -L
1,1,maximize,alias:0,west -L 2,1,maximize,alias:0,northeast -L
3,max,horizontal,alias:0,southeast
$ xwinreg cycle -w -r 3 -d clock
$ xwinreg cycle -w -r 1,3 -d clock -j
$ xwinreg cycle -d clock
```

Another nice thing is focus toggling with a kind of visual bell:
```bash
$ xwinreg focus-toggle -d next
$ xwinreg focus-toggle -d preview
```

As you can see, it is quite easy to build layouts. Feel free to follow up and
create your own. If you like, you can configure your own frame and region
aliases.

## Enviroment ##

* `<TMPDIR>`: By default, Tmp File will be written as
  `<TMPDIR>/xwinreg_default.tmp`, otherwise as `/tmp/xwinreg_default.tmp`.
* `<XWINREG_CONF_FILE>`: Use this instead of option `-C`, if you want to use a
  Conf File.
* `<XWINREG_INPUT_FILE>`: Use this instead of option `-I`.
* `<XWINREG_TMP_FILE>`: Specify this instead default setting and instead using
  `<XWINREG_TMP_FILE>` in a Conf File.

## Configurations ##

By default, `xwinreg`(1) needs no Conf File, because all important geometries
will be calculated in the script. You can also use the relating options on
command line. So, only use a Conf File, if you want to work with several frames
(and several Tmp Files are needed) or if you need to set own aliases for frame
and region geometries. Along with this programm comes an exemplary Conf File.
Specify a Conf File with option `-C` or use `<XWINREG_CONF_FILE>`. You can set
following parameters:

* enviroment variables
	* `XWINREG_TMP_FILE=<FILE>`
	* `XWINREG_INPUT_FILE=<FILE>`
* normal scalar variables
	* `workarea_x=<PX>`
	* `workarea_y=<PX>`
	* `workarea_width=<PX>`
	* `workarea_height=<PX>`
	* `frame_x=<PX>`
	* `frame_y=<PX>`
	* `frame_width=<PX>`
	* `frame_height=<PX>`
	* `row_number=<INT>`
	* `col_number=<INT>`
* associativ array variables: You can use it with above variables. You need to
  set them inside a function called
  `__xwr_xwinreg_calculate_calculating_frame_alias` respectively
  `__xwr_xwinreg_calculate_calculating_region_alias` and declare it with
  `declare -gA frames` respectively `declare -gA regions`.
    * `frames[<ALIAS>]="<X> <Y> <W> <H>"`
	* `regions[<ALIAS>]="<X> <Y> <W> <H>"`

## Notes ##

* If no workarea geometry is set, `<_NET_WORKAREA>` is used.
* Currently, window decoration is not considered.
* If no frame geometry is set, `<_NET_WORKAREA>` is used as frame. Every new
  frame needs its own Tmp File. In other words: all layouting takes place in one
  frame. You can specify another Tmp File with option `-T`, or you may create
  several Conf Files.
* Options on command line overwrites variables in a Conf File.
* You can specify region aliases in a Conf File, which will be read by action
  `l` and `L` and written to a Tmp File.
* If you use action `-l`, actually, the first option needs to be `-r`.
* In the docs there is a script called `get_xids.sh`, which you can use instead
  `wmctrl -l` for getting the x window ids.

## Openbox ##

The best way to use `xwinreg`(1) is to create several shell scripts and call
them with keybinds. There are some example scripts in this repo for layouting
with one frame and two regions.

In `openbox`(1) it is nice to use them with its own actions for seizing and
moving of windows. In the repo there is also a `rc.xml` with sections
`<keyboard>` and `<applications>` and the script `dmenu_xwin_list.sh`.

```
rc.xml KEYBINDS

 0      A-Escape        ToggleDockAutohide
 1      W-A-Left        DesktopLeft
 2      W-A-Right       DesktopRight
 3      W-S-Left        SendToDesktopLeft
 4      W-S-Right       SendToDesktopRight
 5      W-A-Down        ToggleShowDesktop
 6      W-F4            Close
 7      W-Down          Iconify
 8      W-Escape        ToggleDecorations
 9      W-0x23          UnmaximizeFull; ResizeRelative: bottom=-1%
10      W-0x33          UnmaximizeFull; ResizeRelative: bottom=1%
11      W-0x3C          UnmaximizeFull; ResizeRelative: right=-1%
12      W-0x3D          UnmaximizeFull; ResizeRelative: right=1%
13      W-0x30          UnmaximizeFull; MoveRelative: x=0 , y=1%
14      W-0x22          UnmaximizeFull; MoveRelative: x=0 , y=-1%
15      W-m             UnmaximizeFull; MoveRelative: x=-1% , y=0
16      W-0x3B          UnmaximizeFull; MoveRelative: x=1% , y=0
17      W-1             xwinreg_master_west.sh
18      W-2             xwinreg_master_north.sh
19      W-3             xwinreg_master_east.sh
20      W-4             xwinreg_master_south.sh
21      W-5             xwinreg_grid_square_horizontal.sh
22      W-6             xwinreg_grid_square_vertical.sh
23      W-7             xwinreg_grid_horizontal.sh
24      W-8             xwinreg_grid_vertical.sh
25      W-9             xwinreg_hide_active_region.sh
26      W-0             xwinreg_unhide_active_region.sh
27      W-0x14          xwinreg_maximize_all.sh
28      W-0x5E          xwinreg_focus_toggle_next.sh
29      W-S-0x5E        xwinreg_focus_toggle_preview.sh
30      W-0x76          xwinreg_cycle_clock.sh
31      W-0x6E          xwinreg_cycle_anticlock.sh
32      W-0x70          xwinreg_cycle_reverse.sh
33      W-0x77          xwinreg_cycle_reg_clock.sh
34      W-Tab           NextWindow
35      W-S-Tab         PreviousWindow
36      W-space         dmenu_xwin_list.sh
37      A-Tab           client-list-combined-menu
38      A-space         root-menu
39      W-Print         scrot '%Y-%m-%d--%s_$wx$h.png' -e 'mv $f ~/Bilder/ & viewnior ~/Bilder/$f'
40      W-A-Print       scrot -d 10 '%Y-%m-%d--%s_$wx$h.png' -e 'mv $f ~/Bilder/ & viewnior ~/Bilder/$f'
41      W-b             gmrun
42      W-t             xterm
43      W-u             urxvt
44      W-A-l           bash -c "slock"
45      W-s             xscreensaver-demo
46      W-v             acti.sh --gui
47      W-r             arandr
48      W-A-C           xwinreg_close_active_region.sh
49      W-A-F           xwinreg_focus_active_region.sh
50      W-A-1           UnmaximizeFull; MoveResizeTo: x=0, y=0 , w=50% , h=50%
51      W-A-2           UnmaximizeFull; MoveResizeTo: x=0, y=0 , w=100% , h=50%
52      W-A-3           UnmaximizeFull; MoveResizeTo: x=50%, y=0 , w=50% , h=50%
53      W-A-4           UnmaximizeFull; MoveResizeTo: x=50%, y=0 , w=50% , h=100%
54      W-A-5           UnmaximizeFull; MoveResizeTo: x=50%, y=50% , w=50% , h=50%
55      W-A-6           UnmaximizeFull; MoveResizeTo: x=0, y=50% , w=100% , h=50%
56      W-A-7           UnmaximizeFull; MoveResizeTo: x=0, y=50% , w=50% , h=50%
57      W-A-8           UnmaximizeFull; MoveResizeTo: x=0, y=0 , w=50% , h=100%
58      W-A-9           UnmaximizeFull; MoveResizeTo: x=center, y=center , w=50% , h=50%
59      W-A-Return      ToggleMaximizeFull
60      W-A-F12         ToggleFullscreen
61      W-A-m           UnmaximizeFull; MoveToEdge: direction=west
62      W-A-0x3B        UnmaximizeFull; MoveToEdge: direction=east
63      W-A-0x30        UnmaximizeFull; MoveToEdge: direction=south
64      W-A-0x22        UnmaximizeFull; MoveToEdge: direction=north
65      W-A-0x3D        UnmaximizeFull; GrowToEdge: direction=east
66      W-A-0x33        UnmaximizeFull; GrowToEdge: direction=south
67      W-A-0x3C        UnmaximizeFull; ShrinkToEdge: direction=west
68      W-A-0x23        UnmaximizeFull; ShrinkToEdge: direction=north
```

## BUGS & REQUESTS ##

Report it on https://github.com/D630/xwinreg/issues

## ToDO ##

All is work in progress. See file `TODO`, which comes along with this programm.
