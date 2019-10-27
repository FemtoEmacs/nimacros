# Library: consp.nim
import strutils, macros
type
  SExprKind = enum Intp, Floatp, St, Sym, consp
  SExpr = ref object
       case kind: SExprKind
       of Intp: intVal: int
       of Floatp: floatVal: float
       of Sym: symb: string
       of St: str: string
       of consp: h, t: SExpr

template mI*(a:int): SExpr= SExpr(kind: Intp, intVal: a)
template sy*(s: string): SExpr= SExpr(kind: Sym, symb: `s`)
template car*(s:SExpr): SExpr= s.h
template cdr*(s:SExpr): Sexpr= s.t
template cons*(x:SExpr, y:SExpr): SExpr= SExpr(kind: consp, h: x, t: y)

proc `$`*(se: SExpr): string =
  case se.kind
  of Intp: result= $se.intVal
  of Floatp: result = $se.floatVal
  of ST: result = '"' & se.str & '"'
  of Sym: result = se.symb
  of consp:
    result.add("(")
    var (r, ind) = (se, 0)
    while r != nil:
      result.add(indent($r.car, ind))
      (r, ind)= (r.cdr, 1)
    result.add(")")

let plus*{.compileTime.}=  "+".sy
proc walkAST*(e:SExpr): NimNode =
   case e.kind:
     of Sym: return newIdentNode e.symb
     of Intp: return newLit e.intVal
     of consp:
       if car(e) == plus:
         return nnkCall.newTree( newIdentNode"+",
                                 e.cdr.car.walkAST,
                                 e.cdr.cdr.car.walkAST)
     else: return newLit "Erro"

