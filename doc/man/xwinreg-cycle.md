xwinreg-cycle(1) -- cycle order of regions or windows.
================================================

## XWINREG
Part of `xwinreg`(1).
## SYNOPSIS
xwinreg-cycle [-T] (-h|-w -r|-v|) -d (-j|-k|)
## REQUIREMENT
GNU bash, grep, sed, xprop
## DESCRIPTION
`xwinreg-cycle`(1) reads variables inside a Tmp File and prepares cycling of specified regions or windows. The modified variables will be written to the Tmp File. After that, `xwinreg-layout`(1) can perform its layouts with new geos and/or new order of x window ids.
## OPTIONS
* `-d` <YDIREC>:
 Specify direction of cycling.

* `-h`:
 Display a short help.

* `-j`:
 Used with options `-w` and `-r` with more than one region as argument (Example: `-r 1,3`). Cycling takes place between regions; without this option, windows are only cycled inside specific regions.

* `-k`:
 Cycle windows and layout-actions, but keep region position. Without this option, region positions are cycled (together with windows and layout-actions).

* `-r` <REG>:
 Select, which regions should be processed.

* `-T` <FILE>:
 Specify a nonregular Tmp file.

* `-v`:
 Print current version of `xwinreg-cycle`(1).

* `-w`:
 Indicate that windows (not regions) should be processed.

## ARGUMENTS
* <FILE>:
 Regular file or named pipe.

* <REG>:
 Up to this sample: `1` or `1,3` or `1-3` or `1,2-3`. Additional: `active` or `all`.

* <YDIREC>:
 `clock`, `anticlock` or `reverse`.

## EXAMPLES
 xwinreg-cycle -w -r all -d clock

 xwinreg-cycle -w -r active -d anticlock

 xwinreg-cycle -w -r 1,3 -d clock

 xwinreg-cycle -w -r 1,3 -d clock -j

 xwinreg-cycle -d anticlock

 xwinreg-cycle -k -d clock

## ENVIROMENT
* <TMPDIR>:
 By default, Tmp File will be written as **TMPDIR/xwinreg_default.tmp**, otherwise as **/tmp/xwinreg_default.tmp**.

* <XWINREG_TMP_FILE>:
 Specify this instead default setting and instead using <XWINREG_TMP_FILE> in a Conf File.

## BUGS & REQUESTS
Report it on **https://github.com/D630/xwinreg/issues**
## LICENSE
`xwinreg-cycle`(1) is licensed with GNU GPLv3. You should have received a copy of the GNU General Public License along with this program. If not, see for more details **http://www.gnu.org/licenses/gpl-3.0.html**.
## SEE ALSO
`bash`(1), `grep`(1), `sed`(1), `x`(7), `xprop`(1), `xwinreg`(1), `xwinreg-calculate`(1), `xwinreg-close`(1), `xwinreg-focus`(1), `xwinreg-focus-toggle`(1), `xwinreg-hide`(1), `xwinreg-id`(1), `xwinreg-layout`(1), `xwinreg-move-to-desk`(1)
