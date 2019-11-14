#!/usr/bin/env -S nim --hints:off
mode = ScriptMode.Silent
from os import `/`
if paramCount() > 3 and fileExists(paramStr(3) & ".nim"): 
  let
    app = paramStr(3)
    src = app & ".nim"
    exe = app & ".x"
    c = "nim c --hints:off --nimcache:xx -d:danger -o:"

  exec c & exe & " " & src
  echo c & exe & " " & src
  mvFile exe, "bin" / exe
else: echo "Usage: ./build.nims <app without extension>"

