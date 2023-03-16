#!/usr/bin/env python3

# Import/export G Hub settings for version control

import sqlite3, sys, os, pathlib

home = pathlib.Path.home()
config_file = os.path.join(home, "AppData", "Local", "LGHUB", "settings2.db")
export_file = os.path.join(os.path.dirname(os.path.realpath(__file__)), "ghub.json")

if sys.argv[1] == "export":
  config = {}
  with sqlite3.connect(config_file) as conf_db:
    cur = conf_db.cursor()
    res = cur.execute("SELECT * FROM main.data")
    config_bytes = res.fetchone()[2]
    with open(export_file, 'wb') as f:
      f.write(config_bytes)
elif sys.argv[1] == "import":
  with open(export_file, 'rb') as f:
    config_bytes = f.read()
    with sqlite3.connect(config_file) as conf_db:
      cur = conf_db.cursor()
      res = cur.execute(f"UPDATE data SET file = (?)", (config_bytes,))
else:
  print("Either import or export")
