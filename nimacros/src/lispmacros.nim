# nim c -o:cons.x -d:danger --hints:off --nimcache:xx lispmacros.nim 
import os, strutils, macros, consp

macro def(id:untyped, x:untyped, y:untyped): untyped=
  let ix= x.strVal.sy
  let iy= y.strVal.sy
  let body= cons(plus, cons(ix, cons(iy, nil))).walkAST
  quote do:
    proc `id`(`x`: int, `y`: int): int=
       `body`

def(sum, cx, cy)

echo cons("hi".sy, cons(42.mI, cons(cons("world".sy, nil), nil)))
echo sum(paramStr(1).parseInt, 8)
 
