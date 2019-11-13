#› nim c --nimcache:xx -o:recfib.x -d:danger --hints:off recfib.nim
import os, strutils
proc fib(n: int): int =
  if n<2: result= n+1
  elif n<3: result= fib(n-1)+fib(n-2)
  else: result= fib(n-3)+fib(n-2)+fib(n-2)

echo fib(paramStr(1).parseInt)

