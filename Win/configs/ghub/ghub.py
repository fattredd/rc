#!/usr/bin/env python

# load/dump G Hub settings for version control

import sqlite3, sys, os, pathlib, subprocess

home = pathlib.Path.home()
config_file = os.path.join(home, "AppData", "Local", "LGHUB", "settings.db")
dump_file = os.path.join(os.path.dirname(os.path.realpath(__file__)), "ghub.json")

def get_process(proc_name="lghub_agent.exe"):
  result = subprocess.run(
    ["wmic", "process", "where", f"name='{proc_name}'", "get", "ExecutablePath"],
    stdout=subprocess.PIPE)
  data_str = result.stdout.decode("ASCII")
  return data_str.strip().split("\r\r\n")[1]

def fork_process(proc_path):
  subprocess.Popen([proc_path],
    creationflags=subprocess.CREATE_NEW_PROCESS_GROUP)

def kill_process(proc_name):
  subprocess.run(["taskkill", "/F", "/IM", proc_name])

if len(sys.argv) == 1:
  print("Either load or dump")
  exit(1)
if sys.argv[1] == "dump":
  config = {}
  agent_proc = get_process("lghub_agent.exe")
  kill_process("lghub_agent.exe")
  with sqlite3.connect(config_file) as conf_db:
    cur = conf_db.cursor()
    res = cur.execute("SELECT * FROM main.data")
    config_bytes = res.fetchone()[2]
    with open(dump_file, 'wb+') as f:
      f.write(config_bytes)
  fork_process(agent_proc)
  print("dumped to", dump_file)
elif sys.argv[1] == "load":
  agent_proc = get_process("lghub_agent.exe")
  kill_process("lghub_agent.exe")
  with open(dump_file, 'rb') as f:
    config_bytes = f.read()
    with sqlite3.connect(config_file) as conf_db:
      cur = conf_db.cursor()
      res = cur.execute(f"UPDATE data SET file = (?)", (config_bytes,))
  fork_process(agent_proc)
  print("loaded from", dump_file)
else:
  print("Either load or dump")
  exit(1)
