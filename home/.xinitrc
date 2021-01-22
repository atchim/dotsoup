#!/usr/bin/env fish

set -l usage '.xinitrc
Init a X session.

Usage
  startx ~/.xinitrc [-h|--help] [session]
  xinit [-h|--help] [session]

Flags
  -h, --help  Print help information and exit.

Positional Arguments
  session  The name of the session to run. It also may be program name.'

argparse -n .xinitrc -X 1 h/help -- $argv
or exit 1

if set -lq _flag_help
  echo $usage
  exit
end

test -z $argv[1]
and set -l session bspwm
or set -l session $argv[1]

switch $session
  case bspwm
    sxhkd $HOME/.config/sxhkd/bspwm &
    ~/.config/polybar/launch bspwm &
    ~/.fehbg &
    exec bspwm
  case '*'
    exec $session
end
