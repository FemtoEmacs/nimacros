# nim c -d:release -o:ird.x --nimcache:lixo ird.nim
import os, strutils

iterator valid[T](a: seq[T]): T=
  for x in a:
     if x.len != 0: yield x

proc avg(xs: seq[string]): float =
  result= 0.0
  var n= 0.0
  for x in valid(xs):
    n= n+1
    result= result+x.parseFloat
  result= result/n

proc main() =
  if paramCount() < 1: quit("Usage: " & paramStr(0) & " fname")
  let
    s = readFile(paramStr(1)).split(Whitespace+{','})
  echo avg(s)

main()
