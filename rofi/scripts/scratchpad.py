#!/usr/bin/env python3

import os
import sys
import i3ipc

i3 = i3ipc.Connection(auto_reconnect=True)

def scratchpad_windows():
  windows = i3.get_tree().scratchpad().descendants() 
  return [window for window in windows if window.window_title]

def print_window_count():
  windows = scratchpad_windows()
  print(len(windows) or "", flush=True)

def focus_window(id):
  i3.command(f"[con_id={id}] focus")

def on_window_move(self, ev):
  if (ev.change):
    print_window_count()

if "ROFI_INFO" in os.environ:
  focus_window(os.environ["ROFI_INFO"])
  sys.exit()

if len(sys.argv) < 2:
  for win in scratchpad_windows():
    print(f"{win.window_title}\0info\x1f{win.ipc_data['id']}")
  sys.exit()

if sys.argv[1] == "--watch":
  print_window_count()
  i3.on(i3ipc.Event.WINDOW_MOVE, on_window_move)
  i3.main()
