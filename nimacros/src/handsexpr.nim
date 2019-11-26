import os, strutils, macros

type
  Node = ref object
    hd: SExpr
    tl: SExpr
  SExprKind = enum
    isINT, isFLT, isSTR, isID, isKw, isLST
  SExpr = ref object
    case kind: SExprKind
    of isINT: iVal: int
    of isFLT: fVal: float
    of isSTR: sVal: string
    of isID: id: string
    of isKW: kwd: string
    of isLST: cns: Node

proc mI(a:int): SExpr=
   result= SExpr(kind: isINT, iVal: a)

proc mId(s:string): SExpr=
  result=  SExpr(kind: isID, id: s)

proc mK(s:string): SExpr=
  result= SExpr(kind: isKW, kwd: s)

proc car(s:SExpr) : SExpr=
  if s == nil: s
  else: s.cns.hd

proc cdr(s:SExpr) : Sexpr=
  if s == nil: s
  else: s.cns.tl

proc cons(x:SExpr, y:SExpr) : SExpr=
  result= SExpr(kind: isLST, cns: Node(hd: x, tl: y))

proc `$`*(se: SExpr): string =
  case se.kind
  of isINT: result= $se.iVal
  of isFLT: result = $se.fVal
  of isSTR: result = '"' & se.sVal & '"'
  of isID: result = se.id
  of isKW: result = se.kwd
  of isLST:
    result.add("(")
    var r = se
    if r != nil:
      result.add($r.cns.hd)
      r= r.cns.tl
    while r != nil:
      result.add(indent($r.cns.hd, 2))
      r= r.cns.tl
    result.add(")")

# result = nnkStmtList.newTree(nnkForStmt.newTree(ix, rng, stmts))

macro prs(s: string) : untyped=
  result = parseExpr(s.strVal)

macro typecheck(x: typed): untyped=
  echo "The type is: ", repr x.getType()
  result = newStmtList()

template stringParseTest(x) = typecheck prs x

var xs: SExpr= nil

let iFor = mK "for"

let progn = mK "progn"

let ixx= mId "ixx"

macro iter(i, c1, c2, stm: untyped): untyped=
  result= nnkStmtList.newTree(
    nnkForStmt.newTree(
      i, infix(c1, "..", c2), stm))

proc main() =
   var xs= cons(mI 42, cons(cons(iFor,  nil), nil))
   echo xs 
   echo "for-in-list= ", car(car (cdr xs))
   echo "iFor== for-in-list? ", iFor == car(car (cdr xs))
   echo ixx
   iter(i, 1,2,):
     echo i
   stringParseTest("cons(mI 42, nil)")

main()
 
