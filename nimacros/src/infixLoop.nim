# infixLoop.nim
import macros, strutils, os

proc parseArgs(cmd: NimNode): (NimNode, NimNode) =
  expectKind(cmd[0], nnkIdent)
  expectKind(cmd[1], nnkIdent)
  doAssert cmd[0].strVal == "++="
  result = (cmd[1], cmd[2]) 

macro rpt(cmd: untyped, stmts: untyped): untyped =
  expectKind(cmd, nnkInfix)
  expectKind(stmts, nnkStmtList)
  let (iterVar, toIdx) = parseArgs(cmd)
  result = quote do:
    for `iterVar` in 1..`toIdx`:
      `stmts`

rpt j ++= paramStr(1).parseInt:
    echo j, "- Give me some beer"

