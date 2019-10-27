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
template mS*(s:string): SExpr= SExpr(kind: St, str: s)
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
    var r = se
    if r != nil:
      result.add($r.car)
      r= r.cdr
    while r != nil:
      result.add(indent($r.car, 2))
      r= r.cdr
    result.add(")")

let plus*{.compileTime.}=  "+".sy
proc walkAST*(e:SExpr): NimNode =
   case e.kind:
     of Sym: return newIdentNode e.symb
     of Intp: return newLit e.intVal
     of consp:
       if car(e) == plus:
         var callTree = nnkCall.newTree()
         callTree.add newIdentNode"+"
         callTree.add e.cdr.car.walkAST
         callTree.add e.cdr.cdr.car.walkAST
         return callTree
     else: return newLit "Erro"

