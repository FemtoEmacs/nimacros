import os, strutils, math

type LL= ref object of RootObj
    car: float
    cdr: LL

template car(a:untyped) : untyped=
  if a == nil: quit("Empty stack")
  else: a.car

template `>>` (a,b:untyped): untyped= LL(car: a, cdr: b)

proc eval(x: string, s: var LL)=
  try: s= x.strip.parseFloat >> s
  except:
    case  x:
      of "+": s= (car s) + (car s.cdr) >> s.cdr.cdr
      of "x": s= (car s) * (car s.cdr) >> s.cdr.cdr
      of "/": s= (car s.cdr) / (car s) >> s.cdr.cdr
      of "-": s= (car s.cdr) - (car s) >> s.cdr.cdr
      of "expt": s= pow(s.cdr.car, s.car)  >> s.cdr.cdr
      of "fv": s= pow(1.0 + s.cdr.car/100, s.car) *
                      s.cdr.cdr.car >> s.cdr.cdr.cdr
      of "neg": s= -(car s) >> s.cdr
      else: quit("Error in eval")

var s=  ""
var stk: LL= nil
var stack: LL= nil

stdout.write "> "
while stdin.readline(s) and s != "quit":
  for x in s.splitWhitespace:
    eval(x, stk)
  stack= stk
  while stack != nil:
    echo stack.car
    stack= stack.cdr
  stdout.write "> "

