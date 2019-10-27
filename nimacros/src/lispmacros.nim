import os, strutils, macros, consp

macro def(id:untyped, x:untyped, y:untyped): untyped=
  let ix= x.strVal.sy
  let iy= y.strVal.sy
  let body= cons(plus, cons(ix, cons(iy, nil))).walkAST
  quote do:
    proc `id`(`x`: int, `y`: int): int=
       `body`

def(sum, cx, cy)

proc main() =
    echo cons("hi".sy, cons(cons("world".sy, nil), nil))
    echo sum(paramStr(1).parseInt, 8)

main()
 
