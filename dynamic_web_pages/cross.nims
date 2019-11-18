#!/usr/bin/env -S nim --hints:off
mode = ScriptMode.Silent
if paramCount() > 2 and fileExists(paramStr(3) & ".nim"): 
  let
    app = paramStr(3)
    src = app & ".nim"
    exe = "nim" & app & ".n "
    c = "nim c --nimcache:xx --os:linux --cpu:amd64 -d:release -o:"
    cc= " --passL:\"-static\""
  exec c & exe & " " & cc & " " & src
  echo c & exe & " " & cc & " " & src
else: echo "Usage: ./build.nims <app without extension>"

