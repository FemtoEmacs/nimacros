# nim c -d:release -o:xrd.x rd.nim

import os, strutils, sequtils, sugar

proc main() =
  proc avg(xs: seq[string]): float=
     var sm, n = 0.0
     for i, x in xs:
       try:
          sm = sm + x.strip.parseFloat
          n= n + 1.0
       except: discard
       finally: result= sm/n

  if paramCount() < 1: quit("Usage: " & paramStr(0) & " filename")
  let xs = readFile(paramStr(1)).split(Whitespace+{','})
  echo avg(xs)

main()
  
