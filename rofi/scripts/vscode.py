#!/usr/bin/env python3

import os
import sys
import re
import i3ipc

i3 = i3ipc.Connection(auto_reconnect=True)

WORKSPACE_PATH = os.path.expanduser("~/.workspaces")
ICON_WORKSPACE = "user-blue-desktop"
ICON_WINDOW = "visual-studio-code"

def get_workspaces():
  return sorted([f.split(".")[0] for f in os.listdir(WORKSPACE_PATH) if '.' in f])

def open_workspace(name):
  fname = os.path.join(WORKSPACE_PATH, f"{name}.code-workspace")
  if os.path.exists(fname): os.system(f"code {fname}")

def get_workspace_windows():
  output = {}
  for window in i3.get_tree().find_titled('\(Workspace\) - Visual Studio Code'):
    search = re.search('(\S+) \(Workspace\)', window.window_title or "")
    if search: output[search.group(1)] = window.ipc_data["id"]
  return output

def get_code_windows():
  return i3.get_tree().find_classed("Code")

def focus_window(id):
  i3.command(f"[con_id={id}] focus")

def print_window_count(*kwargs):
  print(len(get_code_windows()), flush=True)

def print_item(name, icon, info):
  print(f"{name}\0icon\x1f{icon}\x1finfo\x1f{info}")

info = os.environ.get("ROFI_INFO")
if info and ":" in info:
  match info.split(":"):
    case ["launch", value]: open_workspace(value)
    case ["switch", value]: focus_window(value)
  sys.exit()

if sys.argv[1] == '--workspaces':
  windows = get_workspace_windows()
  for workspace in get_workspaces():
    if workspace in windows:
      print_item(workspace, ICON_WINDOW, f"switch:{windows[workspace]}")
    else:
      print_item(workspace, ICON_WORKSPACE, f"launch:{workspace}")

if sys.argv[1] == '--windows':
  for window in get_code_windows():
    print_item(window.window_title, ICON_WINDOW, f"switch:{window.ipc_data['id']}")

if sys.argv[1] == '--watch':
  print_window_count()
  i3.on(i3ipc.Event.WINDOW, print_window_count)
  i3.main()