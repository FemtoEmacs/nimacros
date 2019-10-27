import os, strutils, macros

type
  SExprKind = enum
    IntScalar, FloatScalar, St, Sym, consp
  SExpr = ref object
    case kind: SExprKind
    of IntScalar: intVal: int
    of FloatScalar: floatVal: float
    of Sym: symbol: string
    of St: str: string
    of consp: car, cdr: SExpr

proc mI(a:int): SExpr=
   result= SExpr(kind: IntScalar, intVal: a)

proc sy(s:string): SExpr=
  result=  SExpr(kind: Sym, symbol: s)

proc mS(s:string): SExpr=
  result=  SExpr(kind: St, str: s)

proc car(s:SExpr) : SExpr=
  if s == nil: s
  else: s.car

proc cdr(s:SExpr) : Sexpr=
  if s == nil: s
  else: s.cdr

proc cons(x:SExpr, y:SExpr) : SExpr=
  result= SExpr(kind: consp, car: x, cdr: y)

proc `$`*(se: SExpr): string =
  case se.kind
  of IntScalar: result= $se.intVal
  of FloatScalar: result = $se.floatVal
  of ST: result = '"' & se.str & '"'
  of Sym: result = se.symbol
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


proc walkAST(e:SExpr): NimNode =
   case e.kind:
     of Sym: return newIdentNode e.symbol
     of IntScalar: return newLit e.intVal
     else: return newLit "Erro"

let ii{.compileTime.} = "i".sy.walkAST

macro iter(jj: untyped, c1: untyped, c2: untyped, stm: untyped): untyped=
  let
    jx= jj.strVal
    p= int(c1.intVal)
  result= nnkStmtList.newTree(
    nnkForStmt.newTree(jx.sy.walkAST, 
        infix(p.mI.walkAST, "..", c2), stm))

proc main() =
  iter(j, 2, paramStr(1).parseInt):
    echo j, cons(sy("hi"), nil)

main()
 
