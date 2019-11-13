# File: iterfib.nim
import os, strutils

proc fib(n: int): int =
  var (r1, r2) = (2, 1)
  for i in 2..n:
    (r1, r2) = (r1+r2, r1)
  result= r1

echo fib(paramStr(1).parseInt)

# A one line comment
