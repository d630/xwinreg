##### 0.3.0.0 Sun Dec 14 CET 2014
- remove subscripts. `xwinreg`(1) is one script again
- revise code base
- change names of arguments `<DESK>`, `<LACT>`, `<ODIREC>`, `<REG>` and `<YDIREC>`
- chane long command names of `-ww`, `-wh`, `-fh` and `-fw`
- remove dependency on `grep`(1)
- update docs

##### 0.2.0.0 Sat Jun 14 13:28:54 2014 +0200
- The hole script is rewritten: xwinreg(1) is now a wrapper script for xwinreg-calculate(1), xwinreg-close(1), xwinreg-cycle(1), xwinreg-focus(1), xwinreg-focus-toggle(1), xwinreg-hide(1),  xwinreg-id(1), xwinreg-layout(1) and xwinreg-move-to-desk(1). These scripts may be called directly with short options. They have their own version number and help option.
- All scripts has now own Manpages.
- xwinreg works now with associative arrays instead normal index array variables without eval calling.
- The wrapper xwinreg(1) has now also a gnu-like long command line syntax.
- Introduce new enviroment variable called <XWINREG_INPUT_FILE>.
- The repo has now a dir called `doc` with examples, scripts, and a rc.xml file for openbox with keybinds.
- At the moment, not the hole output of xwinpp(1) will be read. We use only: win_number, win_xid, win_geo_x_y and win_geo_w_h.
- Option -F (--file) is renamed into -I (--input-file).
- Action -reset, -seize and -move with option -R are skipped until 0.3.0.0, because they need to be rewritten.
- Long option name of -o is now --focus-toggle.
- We can now perform cycling in a specified region, optionally with the flag -j.
- move-to-desk works now with better arguments for option -D.
- Action -U is now deprecated; -H works now with -A and its arguments `add` and `remove`.

##### 0.1.0.14 Thu May 22 10:13:42 2014 +0200
##### 0.1.0.0 Feb 10 2014
