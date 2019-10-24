# nim c -d:release -o:xrd.x rd.nim
import os, strutils

type Node= ref object of RootObj
    car: float
    cdr: Node

template car(a:untyped) : untyped=
  if a == nil: quit("Empty stack")
  else: a.car

template `>>` (a,b:untyped): untyped= Node(car: a, cdr: b)

var s: Node = nil

proc eval(x: string)=
  try: s= x.strip.parseFloat >> s
  except:
    case  x:
      of "+": s= (car s) + (car s.cdr) >> s.cdr.cdr
      of "x": s= (car s) * (car s.cdr) >> s.cdr.cdr
      of "/": s= (car s) / (car s.cdr) >> s.cdr.cdr
      of "-": s= (car s) - (car s.cdr) >> s.cdr.cdr
      of "neg": s= -(car s) >> s.cdr
      else: quit("Error in eval")

for i in 1 .. paramCount(): eval(paramStr(i))
while s != nil:
  echo s.car
  s= s.cdr
  
