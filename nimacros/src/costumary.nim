import os, strutils


type
  LL= ref object of RootObj
    h:  Unit
    t: LL
  UnitKind= enum
    mi, km, nm
  Unit = ref object
    case kind: UnitKind
      of mi: miVal: float
      of km: kmVal: float
      of nm: nmVal: float

proc `$`*(x:Unit): string=
  case x.kind
    of mi: $x.miVal & "mi"
    of km: $x.kmVal & "km"
    of nm: $x.nmVal

template car(a:untyped) : untyped=
  if a == nil: quit("Empty stack")
  else: a.h

template `>>` (a,b:untyped): untyped= LL(h: a, t: b)

proc eval(x: string, s: var LL)=
  try: s= Unit(kind: nm, nmVal: x.strip.parseFloat) >> s
  except:
    case  x:
      of "km": 
         if (car s).kind == nm:
               (car s).kind= km
         elif (car s).kind == km:
             echo (car s).kmVal, "km"
         else:
           s= Unit(kind: km, kmVal: s.h.miVal * 1.609) >> s.t     
      of "mi": 
         if (car s).kind == nm:
               (car s).kind= mi
         elif (car s).kind == mi:
             echo (car s).miVal, "mi"
         else:
           s= Unit(kind: mi, miVal: s.h.kmVal / 1.609) >> s.t 
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
    echo stack.h
    stack= stack.t
  stdout.write "> "

