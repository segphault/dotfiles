#!/usr/bin/env python3

import os

def print_item(name, icon, info):
  print(f"{name}\0icon\x1f{icon}\x1finfo\x1f{info}")

match os.environ.get("ROFI_INFO", "").split(":"):
  case ["cancel"]: pass
  case ["exit"]: os.system("i3-msg exit")
  case ["suspend"]: os.system("systemctl suspend")
  case ["reboot"]: os.system("systemctl reboot")
  case ["shutdown"]: os.system("systemctl poweroff")
  case ["confirm", command]:
    print(f"\0prompt\x1fAre you sure you want to {command}?")
    print_item("No", "button_cancel", "cancel")
    print_item("Yes", "button_ok", command)
  case default:
    print("\0prompt\x1fPower Menu")
    print_item("Exit", "exit", "confirm:exit")
    print_item("Suspend", "sleep", "confirm:suspend")
    print_item("Reboot", "system-reboot", "confirm:reboot")
    print_item("Shutdown", "system-shutdown", "confirm:shutdown")