xwinreg-id(1) -- get prepared X window ids from xwinpp(1).
=====================================================

## XWINREG
Part of `xwinreg`(1).
## SYNOPSIS
xwinreg-id [-T] (-h|-I|-v)
## REQUIREMENT
GNU bash, grep, xwinpp
## DESCRIPTION
Just as `xwinreg-calculate`(1), `xwinreg-id`(1) is required for layouting with `xwinreg-layout`(1). Its purpose is to read the ouput of `xwinpp`(1) and to create a Tmp File with its variables.

In the wrapper script `xwinreg`(1) you may not call `xwinreg-id`(1) directly; it will be called, if you use the option `-I` to indicate an Input File.
## OPTIONS
* `-h`:
 Display a short help.

* `-I` <FILE>:
 Obtain output of `xwinpp`(1) from <FILE>. If <FILE> is a hyphen, get output from `xwinpp`(1) by reading from standard input.

* `-T` <FILE>:
 Specify a nonregular Tmp file.

* `-v`:
 Print current version of `xwinreg-id`(1).

## ARGUMENTS
* <FILE>:
 Regular file or named pipe.

## EXAMPLES
 xwinpp -F ./list -P 1 -p | xwinreg-id -I -

 xwinpp -F ./list -P 1 -p | xwinreg-id -I - -T ${Home}/tmp/xwinreg.tmp

 xwinreg-id -I - < <(xwinpp -F ./list -P 1 -p)

 xwinreg-id -I ./output-of-xwinpp

 xwinreg-id -I <(xwinpp -F ./list -P 1 -p)

## ENVIROMENT
* <TMPDIR>:
 By default, Tmp File will be written as **TMPDIR/xwinreg_default.tmp**, otherwise as **/tmp/xwinreg_default.tmp**.

* <XWINREG_TMP_FILE>:
 Specify this instead default setting and instead using <XWINREG_TMP_FILE> in a Conf File.

* <XWINREG_INPUT_FILE>:
 Use this instead of option -I.

## BUGS & REQUESTS
Report it on **https://github.com/D630/xwinreg/issues**
## LICENSE
`xwinreg-id`(1) is licensed with GNU GPLv3. You should have received a copy of the GNU General Public License along with this program. If not, see for more details **http://www.gnu.org/licenses/gpl-3.0.html**.
## SEE ALSO
`bash`(1), `grep`(1), `x`(7), `xorg`(1), `xwinpp`(1), `xwinreg`(1), `xwinreg-calculate`(1), `xwinreg-close`(1), `xwinreg-cycle`(1), `xwinreg-focus`(1), `xwinreg-focus-toggle`(1), `xwinreg-hide`(1), `xwinreg-layout`(1), `xwinreg-move-to-desk`(1)
