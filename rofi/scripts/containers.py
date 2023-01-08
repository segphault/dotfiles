#!/usr/bin/env python3

import os
import sys
import docker

client = docker.from_env()

def print_container_count():
  containers = client.containers.list(all=True)
  running = [item for item in containers if item.status == "running"]
  print(len(running), flush=True)

def toggle_status(id):
  item = client.containers.get(id)
  if item.status == "running": item.stop()
  else: item.start()

if "ROFI_INFO" in os.environ:
  toggle_status(os.environ["ROFI_INFO"])
  sys.exit()

if len(sys.argv) < 2:
  for item in client.containers.list(all=True):
    icon = "state_running" if item.status == "running" else "tvdisconnected"
    print("{}\0icon\x1f{}\x1finfo\x1f{}".format(item.name, icon, item.name))
  sys.exit()

if sys.argv[1] == "--watch":
  print_container_count()
  for ev in client.events():
    print_container_count()