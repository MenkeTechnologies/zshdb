# -*- shell-script -*-
# frame.sh - gdb-like "up", "down" and "frame" debugger commands
#
#   Copyright (C) 2008 Rocky Bernstein rocky@gnu.org
#
#   zshdb is free software; you can redistribute it and/or modify it under
#   the terms of the GNU General Public License as published by the Free
#   Software Foundation; either version 2, or (at your option) any later
#   version.
#
#   zshdb is distributed in the hope that it will be useful, but WITHOUT ANY
#   WARRANTY; without even the implied warranty of MERCHANTABILITY or
#   FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
#   for more details.
#   
#   You should have received a copy of the GNU General Public License along
#   with zshdb; see the file COPYING.  If not, write to the Free Software
#   Foundation, 59 Temple Place, Suite 330, Boston, MA 02111 USA.

# Move default values down $1 or one in the stack. 

_Dbg_help_add down \
'down [count]    Set file location for printing down the call stack by 
                count. If count is omitted use 1.'
_Dbg_do_down() {
  _Dbg_not_running && return 1
  typeset -i count=${1:-1}
  _Dbg_adjust_frame $count -1
  _Dbg_print_location
}

_Dbg_help_add frame \
'frame frame-number	Move the current frame to the frame-number'

_Dbg_do_frame() {
  _Dbg_not_running && return 1
  typeset -i pos=${1:-0}
  _Dbg_adjust_frame $pos 0
  _Dbg_print_location
}

# Move default values up $1 or one in the stack. 
_Dbg_help_add up \
'u | up [count]  Set file location for printing up the call stack by 
                count. If count is omitted use 1.'
_Dbg_do_up() {
  _Dbg_not_running && return 1
  typeset -i count=${1:-1}
  _Dbg_adjust_frame $count +1
  _Dbg_print_location
}

_Dbg_alias_add 'd' down
