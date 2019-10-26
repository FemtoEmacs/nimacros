# Based on idea of Vindaar
import macros, strutils, os

proc parseArgs(cmd: NimNode): (NimNode, NimNode) =
  doAssert cmd.len == 1
  expectKind(cmd[1], nnkInfix)
  expectKind(cmd[1][0], nnkIdent)
  expectKind(cmd[1][1], nnkIdent)
  expectKind(cmd[1][2], nnkIdent)
  doAssert cmd[1][0].strVal == "->"
  doAssert cmd[1][1].strVal == "times"
  result = (cmd[0], # leave cmd[0] as is, has to be valid integer expr
            cmd[1][2]) # identifier to use for loop

macro rpt(cmd: untyped, stmts: untyped): untyped =
  expectKind(cmd, nnkCommand)
  expectKind(stmts, nnkStmtList)
  let (toIdx, iterVar) = parseArgs(cmd)
  result = quote do:
    for `iterVar` in 1..`toIdx`:
      `stmts`
  echo result.repr

rpt 3 times -> j:
    echo j, "- Give me some beer"
    echo "Now"

