# make APP=akavelIter
import macros, strutils, os

macro iter(cmd: untyped, stmts: untyped): untyped =
  expectKind(cmd, nnkInfix)
  expectKind(cmd[0], nnKIdent)
  doAssert cmd[0].strVal == "->"
  expectKind(cmd[2], nnkIdent)
  expectKind(stmts, nnkStmtList)
  let (ix, rng) = (cmd[2], cmd[1])
  result = nnkStmtList.newTree(nnkForStmt.newTree(ix, rng, stmts))

iter 2..paramStr(1).parseInt -> j:
    echo j, "- Give me some beer"

