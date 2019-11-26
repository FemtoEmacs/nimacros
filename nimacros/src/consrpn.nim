# nim c -d:release -o:rpn.x --nimcache:lixo rpn.nim
import os, strutils

type LL= ref object of RootObj
    car: float
    cdr: LL

template car(a:untyped) : untyped=
  if a == nil: quit("Empty stack")
  else: a.car

template cons(x: untyped, y: untyped) : untyped=
  LL(car: x,  cdr: y)

proc eval(x: string, s: var LL)=
  try:
    s= x.strip.parseFloat.cons: s
  except:
    case  x:
      of "+":
        s=  ((car s)  + (car s.cdr)).cons: s.cdr.cdr
      of "x":
        s= cons (car s) * (car s.cdr): s.cdr.cdr
      of "/":
        s= cons (car s.cdr) / (car s): s.cdr.cdr
      of "-":
        s= cons (car s.cdr) - (car s): s.cdr.cdr
      of "neg":
        s= cons -(car s): s.cdr
      else: quit("Error in eval")

var stk: LL = nil
for i in 1 .. paramCount(): eval(paramStr(i), stk)
while stk != nil:
  echo stk.car
  stk= stk.cdr
  
