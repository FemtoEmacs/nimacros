import os, strutils, macros

type
  SExprKind = enum
    IntScalar, FloatScalar, St, Sym, consp
  SExpr = ref object
    case kind: SExprKind
    of IntScalar: intVal: int
    of FloatScalar: floatVal: float
    of Sym: symb: string
    of St: str: string
    of consp: car, cdr: SExpr

template mI(a:int): SExpr=
   SExpr(kind: IntScalar, intVal: a)

template sy(s: string): SExpr=
  SExpr(kind: Sym, symb: `s`)

template mS(s:string): SExpr=
  SExpr(kind: St, str: s)

template car(s:SExpr) : SExpr=
  if s == nil: s
  else: s.car

template cdr(s:SExpr) : Sexpr=
  if s == nil: s
  else: s.cdr

template cons(x:SExpr, y:SExpr) : SExpr=
  SExpr(kind: consp, car: x, cdr: y)

proc `$`*(se: SExpr): string =
  case se.kind
  of IntScalar: result= $se.intVal
  of FloatScalar: result = $se.floatVal
  of ST: result = '"' & se.str & '"'
  of Sym: result = se.symb
  of consp:
    result.add("(")
    var r = se
    if r != nil:
      result.add($r.car)
      r= r.cdr
    while r != nil:
      result.add(indent($r.car, 2))
      r= r.cdr
    result.add(")")

let plus{.compileTime.}=  "+".sy

proc walkAST(e:SExpr): NimNode =
   case e.kind:
     of Sym: return newIdentNode e.symb
     of IntScalar: return newLit e.intVal
     of consp:
       if car(e) == plus:
         var callTree = nnkCall.newTree()
         callTree.add newIdentNode"+"
         callTree.add e.cdr.car.walkAST
         callTree.add e.cdr.cdr.car.walkAST
         return callTree
     else: return newLit "Erro"

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
 
