import os, strutils

proc fib(n: int): int =
  if n<2:
    result=1
  elif n<3:
    result=n
  else:
    result= fib(n-3)+fib(n-2)+fib(n-2)

echo fib(paramStr(1).parseInt)

