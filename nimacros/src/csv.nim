# nim c -d:release -o:csv.x --nimcache:lixo csv.nim
import os, strutils, sequtils, sugar

proc main() =
  if paramCount() < 1: quit("Usage: " & paramStr(0) & "fname.data")
  let
    s = readFile(paramStr(1)).split(Whitespace+{','})
    xs= s.filter(x => x.len > 0).map(x => x.parseFloat)
  echo "Average= ", xs.foldl(a+b)/float(xs.len)

main()
