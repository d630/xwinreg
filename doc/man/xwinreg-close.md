xwinreg-close(1) -- close regions gracefully.
========================================

## XWINREG
Part of `xwinreg`(1).
## SYNOPSIS
xwinreg-close [-T] (-h|-r|-v)
## REQUIREMENT
GNU bash, grep, sed, wmctrl, xprop
## DESCRIPTION
`xwinreg-close`(1) reads variables inside a Tmp File and closes specified regions. After closing the Tmp File will be updated.
## OPTIONS
* `-h`:
 Display a short help.

* `-r` <REG>:
 Select, which regions should be processed.

* `-T` <FILE>:
 Specify a nonregular Tmp file.

* `-v`:
 Print current version of `xwinreg-close`(1).

## ARGUMENTS
* <FILE>:
 Regular file or named pipe.

* <REG>:
 Up to this sample: `1` or `1,3` or `1-3` or `1,2-3`. Additional: `active` or `all`.

## EXAMPLES
 xwinreg-close -r active

 xwinreg-close -T ${Home}/tmp/xwinreg.tmp -r 2

## ENVIROMENT
* <TMPDIR>:
 By default, Tmp File will be written as **TMPDIR/xwinreg_default.tmp**, otherwise as **/tmp/xwinreg_default.tmp**.

* <XWINREG_TMP_FILE>:
 Specify this instead default setting and instead using <XWINREG_TMP_FILE> in a Conf File.

## BUGS & REQUESTS
Report it on **https://github.com/D630/xwinreg/issues**
## LICENSE
`xwinreg-close`(1) is licensed with GNU GPLv3. You should have received a copy of the GNU General Public License along with this program. If not, see for more details **http://www.gnu.org/licenses/gpl-3.0.html**.
## SEE ALSO
`bash`(1), `grep`(1), `sed`(1), `wmctrl`(1), `x`(7), `xorg`(1), `xprop`(1), `xwinreg`(1), `xwinreg-calculate`(1), `xwinreg-cycle`(1), `xwinreg-focus`(1), `xwinreg-focus-toggle`(1), `xwinreg-hide`(1), `xwinreg-id`(1), `xwinreg-layout`(1), `xwinreg-move-to-desk`(1)
