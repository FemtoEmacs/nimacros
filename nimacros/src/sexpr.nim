import os, strutils

type
  Node[T]= ref object
    head: SExpr
    tail: Node[T]
  SExprKind = enum
    isINT, isFLT, isSTR, isID, isLST
  SExpr = ref object
    case kind: SExprKind
    of isINT: iVal: int
    of isFLT: fVal: float
    of isSTR: sVal: string
    of isID: id: string
    of isLST: xs: Node[SExpr]

proc cons[T](a:T, n: Node[T]): Node[T] =
  var
    res = Node[T](head: a, tail: n)
  return res

proc mkList(n: int): SExpr =
    result = SExpr(kind: isLST)
    result.xs = nil
    for i in 0..n:
      result.xs =
        cons(SExpr(kind: isINT, iVal: i), result.xs)

proc `$`*(se: SExpr): string =
  case se.kind
  of isINT: result= $se.iVal
  of isFLT: result = $se.fVal
  of isSTR: result = '"' & se.sVal & '"'
  of isID: result = se.id
  of isLST:
    result.add("(")
    var
      r = se.xs
    if r != nil:
      result.add($r.head)
      r= r.tail
    while r != nil:
      result.add(indent($r.head, 2))
      r= r.tail
    result.add(")")

proc soma(xs: SExpr): int=
  var
    r = 0
    s = xs.xs
  while s != nil:
    r = r + s.head.iVal
    s = s.tail
  return r

proc main() =
  if paramCount() < 1:
    quit("Usage: x-sexpr.x 1000")
  let
    n = parseInt(paramStr(1))
  echo mkList(3)
  var
    som = 0
    xs = mkList(1000000)
  for i in 1 .. n:
    som = som + soma(xs)
  echo "Soma= ",  som

main()
 
