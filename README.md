### xwinreg v0.3.0.0 [GNU GPLv3]

`xwinreg`(1) is a bash shell script, that acts like a stupid third party tiling
application on `Xorg`(1). It lets you organize X windows into frames and regions
and then to build your own layouts in a simple way. Therefore, `xwinreg`(1) uses
`xwinpp`(1) to prepare a list of X window ids, and `wmctrl`(1) to interact with
your EWMH/NetWM compatible X Window manager.

In this version you may use following subcommands:

- `close`: close regions gracefully.
- `cycle`: cycle order of regions or windows.
- `focus`: focus all windows in specified regions.
- `focus-toggle`: toggle focus on windows in all regions.
- `hide`: add or remove window property 'hidden' in specified
  regions.
- `layout`: build layouts inside arranged regions and fill them
  rule-based with windows.
- `move-to-desk`: move windows of specified regions to another
  desktop.

There are [many](https://en.wikipedia.org/wiki/Tiling_window_manager) tiling
window managers and third party applications for the X Window System. Only use
`xwinreg`(1), if you have a stacking window manager like `openbox`(1), but
sometimes you want to tile all windows without the mouse and arrange them in
different "layouts".

#### Install

* Get the newest version of `xwinreg`(1) with `$ git clone https://github.com/D630/xwinreg.git` or
  download its last release on https://github.com/D630/xwinreg/tags
* Make `xwinreg` executable and copy it elsewhere into `<PATH>`

Explicitly required:
- `bc`(1)
- `GNU bash`(1)
- `sed`(1)
- `wmctrl`(1)
- `xprop`(1)
- `xwininfo`(1)
- [xwinpp](https://github.com/D630/xwinpp) >= v0.1.2.5

#### Help

```
xwinreg [-I] (-c|-h|-v|-y|-o|-f|-H|-M)
xwinreg -I [-C|-T] [-n|-N|-a|-1|-2|-3|-4|-5|-6|-7|-8] (-l -A -e -g -G -r -x ...)
xwinreg -I [-C|-T] [-n|-N|-a|-1|-2|-3|-4|-5|-6|-7|-8] -L ...

OPTIONS
-------
    OPT                             ARG
    ---                             ---
    -C,  --conf-file=               <FILE>
    -I,  --input-file=              <FILE> or hyphen (-)
    -N,  --number-of-cols=          <INT>
    -T,  --tmp-file=                <FILE>
    -a,  --frame-alias=             <FRAMEALIAS>
    -fh, --frame-h=                 <PX>
    -fw, --frame-w=                  <PX>
    -fx, --frame-x=                 <PX>
    -fy, --frame-y=                 <PX>
    -n,  --number-of-rows=          <INT>
    -wh, --workarea-h=              <PX>
    -ww, --workarea-w=              <PX>
    -wx, --workarea-x=              <PX>
    -wy, --workarea-y=              <PX>

SUBCOMMANDS
-----------
    ACTION                          REQUIRED
    ------                          --------
    -H,  --hide                     <REG> <HACT>
    -L,  --layout-abbrev=           <REGN>,<WINN>,<LACT>,<LENT>:<GRAV>,
                                    <GEO>
    -M,  --move-to-desk             <REG> <DESK> -W
    -c,  --close                    <REG>
    -f,  --focus                    <REG>
    -h,  --help
    -l,  --layout                   <REGN> <WINN> <LACT> <LENT> <GRAV>
                                    <GEO>
    -o,  --focus-toggle             <ODIREC>
    -v,  --version
    -y,  --cycle                    <REG> <YDIREC> -w -k -j

    OPT                             ARG
    ---                             ---
    -A,  --action=                  ( <HACT> | <LACT> )
    -D,  --desk=                    <DESK>
    -G,  --gravity=                 <GRAV>
    -W,  --switch
    -d,  --direction=               ( <ODIREC> | <YDIREC>  )
    -e,  --entity=                  <LENT>
    -g,  --geo=                     <GEO>
    -j,  --join
    -k,  --stack
    -r,  --region=                  ( <REG> | <REGN> )
    -w,  --window
    -x,  --maximum=                 <WINN>

ARGUMENTS
---------
    <DESK>          'curr' or relative to the current desktop 'next' or
                    'prev'. To specify a desktop number (starts at 0)
                    use the prefix 'i:'; a desktop name is prefixed with
                    's:'. Examples: 'i:1'; 's:web'; '\"s:some stuff\"'.
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
    <LACT>          'maxi', 'horiz', 'verti',
                    'grid-horiz', 'grid-verti',
                    'grid-square-horiz' or 'grid-square-verti'.
    <LENT>          'alias', 'px' or 'pro'.
    <ODIREC>        'next' or 'prev'.
    <PX>            Pixel size specified by an integer.
    <REG>           Up to this sample: '1', '1,3', '1-3' or '1,2-3'.
                    Additional: 'active' or 'any'.
    <REGN>          Region number specified by an integer.
    <WINN>          Window number specified by an integer or 'max'.
    <YDIREC>        'clock', 'aclock' or 'rev'.
```

#### Examples

Let us say we have five X windows on a desktop:

```
$ __get_xids() { read -r _ _ _ _ xids < <(xprop -root _NET_CLIENT_LIST) &&
printf '%s\n' ${xids//,/} ; }
$ __get_xids | xwinpp print -I - --visible -P 0
_xwinpp_desk_curr=0
_xwinpp_desk_select=(0)
_xwinpp_win_active=0x340000d
_xwinpp_win_active_geo_x_y=(0,1)
_xwinpp_win_active_geo_w_h=(698,1034)
_xwinpp_win_active_frame_extents=0,0,0,0
_xwinpp_win_active_tags=null
_xwinpp_win_xid=(0x340000d 0x1a0000d 0x1c0000d 0x200000d 0x300000d)
_xwinpp_win_number=5
_xwinpp_win_geo_x_y=(0,1 700,1 700,263 700,525 700,787)
_xwinpp_win_geo_w_h=(698,1034 698,255 698,255 698,255 698,255)
_xwinpp_win_frame_extents=(0,0,0,0 0,0,0,0 0,0,0,0 0,0,0,0 0,0,0,0)
_xwinpp_win_tags=(null null null null null)
```

Now we want to arrange these windows in a layout, for example in a layout, which
we can call "master west". Therefore, we virtually build a frame with the size of the
workspace on the current desktop (desktop "0"); and that frame should be split
into two regions with same width and height, but different x and y position. To
do this, we can use the subcommands `layout` or `layout-abbrev`:

```
$ __get_xids | xwinpp print -I - --visible -P 0 | \
xwinreg -I - \
--layout \
--region=1 \
--maximum=1 \
--action=maxi \
--entity=alias \
--gravity=0 \
--geo=west \
--layout
--region=2 \
--maximum=max \
--action=horiz \
--entity=alias \
--gravity=0
--geo=east
$ __get_xids | xwinpp print -I - --visible -P 0 | \
xwinreg -I - \
-L 1,1,maxi,alias:0,west \
-L 2,max,horiz,alias:0,east
```

Once, a layout is set and a Tmp File is created, we can work with it. A nice thing is focus toggling with a kind of visual bell:

```
$ xwinreg focus-toggle -d next
$ xwinreg focus-toggle -d prev
```

Quite usefull is window cycling. To cycle all windows between all regions:

```
$ xwinreg cycle -w -r any -d clock
$ xwinreg cycle -w -r any -d aclock
$ xwinreg cycle -w -r any -d rev
```

To clockwisely cycle the windows in region two only:

```
$ xwinreg cycle -w -r 2 -d clock
```

To cycle all regions:

```
$ xwinreg cycle -d clock -k
```

If we arrange three regions and fill them up with windows, we can also do
cycling like this:

```
$ __get_xids | xwinpp print -I - --visible -P 0 | \
xwinreg -I - \
-L 1,1,maxi,alias:0,west \
-L 2,1,maxi,alias:0,northeast \
-L 3,max,horiz,alias:0,southeast
$ xwinreg cycle -w -r 3 -d clock
$ xwinreg cycle -w -r 1,3 -d clock -j
$ xwinreg cycle -d clock
```

To hide/unhide windows in region three:

```
$ xwinreg hide -r 3 -A add
$ xwinreg hide -r 3 -A remove
```

To move all windows/regions to another desktop:

```
$ xwinreg -M -r any -D next -W
$ xwinreg -M -r any -D prev -W
```

To close region two:

```
$ xwinreg close -r 2
```

#### Environment

- `<XWINREG_CONF_FILE>`: Use this instead of option `-C`, if you want to use a
  Conf File.
- `<XWINREG_INPUT_FILE>`: Use this instead of option `-I`.
- `<XWINREG_TMP_FILE>`: Use this instead option `-T`. By default, Tmp File will be written as
  `<TMPDIR>/xwinreg_default.tmp` or `/tmp/xwinreg_default.tmp`.

#### Configurations

By default, `xwinreg`(1) needs no Conf File, because all important geometries
will be calculated in the script. You can also use the relating options on
command line. So, only use a Conf File, if you want to work with several frames
(and several Tmp Files are needed) or if you need to set own aliases for frame
and region geometries. Along with this programm comes an exemplary [configuration file](../master/doc/examples/xwinreg.conf.example).
Specify a Conf File with option `-C` or use `<XWINREG_CONF_FILE>`. You can set
following parameters:

- Environment variables
  * `XWINREG_INPUT_FILE=<FILE>`
  * `XWINREG_TMP_FILE=<FILE>`
- Associativ array variables:
  * `_xwinreg_options[col_number]=<INT>`
  * `_xwinreg_options[frame_h]=<PX>`
  * `_xwinreg_options[frame_w]=<PX>`
  * `_xwinreg_options[frame_x]=<PX>`
  * `_xwinreg_options[frame_y]=<PX>`
  * `_xwinreg_options[row_number]=<INT>`
  * `_xwinreg_options[workarea_h]=<PX>`
  * `_xwinreg_options[workarea_w]=<PX>`
  * `_xwinreg_options[workarea_x]=<PX>`
  * `_xwinreg_options[workarea_y]=<PX>`
- Further you can use following associativ array variables, which you need to set inside a function called `__xwinreg_calculate_frame_alias` and/or `__xwinreg_calculate_region_alias`:
  * `frames[<ALIAS>]="<X> <Y> <W> <H>"`
  * `regions[<ALIAS>]="<X> <Y> <W> <H>"`

#### Notes

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
* You may write all long names without masking `--`. Instead of `--help` you may use `help`.

#### See also

The best way to use `xwinreg`(1) is to create several shell scripts and call
them with keybinds. See:

https://github.com/D630/gist-bin-pub/tree/master/get-xids

https://github.com/D630/gist-bin-pub/tree/master/xwinreg-scripts

https://github.com/D630/stow-dot-pub/tree/master/openbox/etc/openbox

#### To do

See file [TODO](../master/doc/TODO.md)

#### Bugs & Requests

Report it on https://github.com/D630/xwinreg/issues
