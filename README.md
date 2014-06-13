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

There are many tiling window managers and third party applications for the X
Window System. Only use `xwinreg`(1), if you have a stacking window manager like
`openbox`(1), but sometimes you want to tile all windows without the mouse and
arrange them in different "layouts". Do not use it, if you do not like to do
things in `bash`(1): `bash`(1) is relative slow (and there are well known other
reasons). I chose it, because I am a kind of newbie. Anyway, most people can
understand its code and `xwinreg`(1) does not need to process much data; it is
still going faster than the blink of my slow eyes. So, for me it is still
usefull.

## Install ##

## Examples ##

The things behind the following are documented in the Manpages of the wrapper
and the subscripts.

Lets say, we have this situation:

```shell
$ Xorg -version

X.Org X Server 1.15.1
[...]
X Protocol Version 11, Revision 0
Build Operating System: Linux 3.2.0-37-generic x86_64 Ubuntu
[...]
xorg-server 2:1.15.1-0ubuntu2 (For technical support please see http://www.ubuntu.com/support)
[...]
```

```shell
$ openbox --version
Openbox 3.5.2
Copyright (c) 2004   Mikael Magnusson
Copyright (c) 2002   Dana Jansens

This program comes with ABSOLUTELY NO WARRANTY.
This is free software, and you are welcome to redistribute it
under certain conditions. See the file COPYING for details.
```

We have two screens, two desktops and current desktop is "0":

```shell
$ echo $DISPLAY ; printf '%*s\n' "$(tput cols)" ' ' | tr ' ' . ; xrandr ; printf
'%*s\n' "$(tput cols)" ' ' | tr ' ' - ; xprop -root -notype | egrep -e
'^_NET_(NUMBER_OF_DESKTOPS|DESKTOP_NAMES|CURRENT_DESKTOP|WORKAREA)'
:0.0
...............................................................................................................................................................................................................................................
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
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
_NET_CURRENT_DESKTOP = 0
_NET_DESKTOP_NAMES = "null", "eins"
_NET_WORKAREA = 0, 1, 1680, 1049, 0, 1, 1680, 1049
_NET_NUMBER_OF_DESKTOPS = 2
```

On desktop "0" we have five visible and maximized X windows with no decorations:

```shell
$ __get_win_xids() { read -r _ _ _ _ xids < <(xprop -root _NET_CLIENT_LIST) &&
printf '%s\n' ${xids//,/} ; } ; __get_win_xids ; printf '%*s\n' "$(tput cols)" '
' | tr ' ' . ; wmctrl -lxG ; printf '%*s\n' "$(tput cols)" ' ' | tr ' ' . ;
__get_win_xids | xwinpp - -s visible -P 1 -p
0x32000a3
0x2000022
0x2200022
0x2400022
0x2800022
...............................................................................................................................................................................................................................................
0x032000a3  0 0    1    1680 1049 emacs24-x.Emacs24     ICH2 ~/code/source/xwinreg/README.md
0x02000022  0 0    1    1680 1049 xterm.XTerm           ICH2 xterm
0x02200022  0 0    1    1680 1049 xterm.XTerm           ICH2 xterm
0x02400022  0 0    1    1680 1049 xterm.XTerm           ICH2 xterm
0x02800022  0 0    1    1680 1049 xterm.XTerm           ICH2 xterm
...............................................................................................................................................................................................................................................
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

```shell
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

```shell
$ __get_win_xids | xwinpp - -s visible -P 1 -p | xwinreg-id -I -
$ xwinreg-calculate
$ xwinreg-layout -L 1,1,maximize,alias:0,west -L 2,max,horizontal,alias:0,east
```

Once, a layout is set and a Tmp File is created, we can work with them. Quite
usefull is window cycling:

To cycle clockwisely all windows between all regions:

```shell
$ xwinreg cycle -w -r all -d clock
```

To cycle clockwisely all regions:

```shell
$ xwinreg cycle -d clock -k
```

If we arrange three regions and fill them up with windows, we could also do
cycling like this:

```shell
$ __get_win_xids | xwinpp - -s visible -P 1 -p | xwinreg -I - -L
1,1,maximize,alias:0,west -L 2,1,maximize,alias:0,northeast -L
3,max,horizontal,alias:0,southeast
$ xwinreg cycle -w -r 3 -d clock
$ xwinreg cycle -w -r 1,3 -d clock -j
$ xwinreg cycle -d clock
```

Another nice thing is focus toggling with a kind of visual bell:
```shell
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

## Openbox ##

## At last ##
