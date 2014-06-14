xwinreg-focus-toggle(1) -- toggle focus on windows in all regions.
===========================================================

## XWINREG
Part of `xwinreg`(1).
## SYNOPSIS
xwinreg-focus-toggle [-T] (-h|-d|-v)
## REQUIREMENT
GNU bash, grep, wmctrl, xrop, xwininfo
## DESCRIPTION
`xwinreg-focus-toggle`(1) reads a Tmp File with variables and changes the active window. After focusing, the Tmp file will be updated.
## OPTIONS
* `-d` <ODIREC>:
 Specify, in which direction the windows are toggled.

* `-h`:
 Display a short help.

* `-T` <FILE>:
 Specify a nonregular Tmp file.

* `-v`:
 Print current version of `xwinreg-focus-toggle`(1).

## ARGUMENTS
* <ODIREC>:
 `next` or `preview`.

* <FILE>:
 Regular file or named pipe.

## EXAMPLES
 xwinreg-focus-toggle -d preview

 xwinreg-focus-toggle -T ${Home}/tmp/xwinreg.tmp -d next

## ENVIROMENT
* <TMPDIR>:
 By default, Tmp File will be written as **TMPDIR/xwinreg_default.tmp**, otherwise as **/tmp/xwinreg_default.tmp**.

* <XWINREG_TMP_FILE>:
 Specify this instead default setting and instead using <XWINREG_TMP_FILE> in a Conf File.

## BUGS & REQUESTS
Report it on **https://github.com/D630/xwinreg/issues**
## LICENSE
`xwinreg-focus-toggle`(1) is licensed with GNU GPLv3. You should have received a copy of the GNU General Public License along with this program. If not, see for more details **http://www.gnu.org/licenses/gpl-3.0.html**.
## SEE ALSO
`bash`(1), `grep`(1), `wmctrl`(1), `x`(7), `xorg`(1), `xprop`(1), `xwininfo`(1), `xwinreg`(1), `xwinreg-calculate`(1), `xwinreg-close`(1), `xwinreg-cycle`(1), `xwinreg-focus`(1), `xwinreg-hide`(1), `xwinreg-id`(1), `xwinreg-layout`(1), `xwinreg-move-to-desk`(1)
