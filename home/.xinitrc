#!/usr/bin/env python3

from argparse import ArgumentParser
from os import environ, execlp, execvp, path
from subprocess import Popen, run


def get_parser():
  """Return the command line argument parser."""

  parser = ArgumentParser(description='init a x session')
  mode = parser.add_mutually_exclusive_group(required=True)

  mode.add_argument(
    '-c',
    '--cmd',
    help='init session as a command',
    metavar=('cmd', 'arg'),
    nargs='+',
  )

  mode.add_argument(
    '-s',
    '--session',
    help='init an actual session',
    metavar='sesh',
  )

  return parser


def init_bspwm():
  """Init X session for bspwm."""
  environ['_JAVA_AWT_WM_NONREPARENTING'] = '1'
  environ['SCREENSHOT_DIR'] = path.expanduser('~/pix/shot')
  environ['SXHKD_SHELL'] = '/bin/bash'
  Popen(['sxhkd', path.expanduser('~/.config/sxhkd/bspwm.sxhkdrc')])
  Popen([path.expanduser('~/.config/polybar/launch'), 'bspwm'])
  Popen([path.expanduser('~/.fehbg')])
  execlp('bspwm', 'bspwm')


if __name__ == '__main__':
  parser = get_parser()
  args = parser.parse_args()

  if args.cmd:
    execvp(args.cmd[0], args.cmd)
  elif args.session:
    if args.session == 'bspwm': init_bspwm()
    else: raise ValueError(f'.xinitrc: invalid session: {args.session}')
