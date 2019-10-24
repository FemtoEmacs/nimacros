import os, strutils

type
  LL= ref object of RootObj
          h:  U
          t: LL
  UnitKind= enum mi= "mi", km= "km", nm= "nm"
  U = ref object
        case kind: UnitKind
           of mi, km, nm: fVal: float

template car(a:untyped) : untyped=
  if a == nil: quit("Empty stack") else: a.h

template psh(knd: untyped, v: untyped, s: untyped) =
  s = LL(h: U(kind: knd, fVal: v), t: s.t)

proc eval(x: string, s: var LL)=
  try: s= LL(h: U(kind: nm, fVal: x.strip.parseFloat), t: s)
  except:
    case x :
      of "km":
         if (car s).kind == nm: (car s).kind= km
         elif (car s).kind == mi: psh(km, s.h.fVal * 1.609, s)
      of "mi":
        if (car s).kind == nm: (car s).kind= mi
        elif (car s).kind == km: psh(mi, s.h.fVal / 1.609, s)
      else: echo "?"

var s=  ""
var stk: LL= nil
var stack: LL= nil
stdout.write "> "
while stdin.readline(s) and s != "q":
  for x in s.splitWhitespace: eval(x, stk)
  stack= stk
  while stack != nil:
    echo stack.h.fVal, stack.h.kind
    stack= stack.t
  stdout.write "> "

