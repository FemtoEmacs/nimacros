# Based on idea of Vindaar
import macros, strutils, os

proc parseArgs(cmd: NimNode): (NimNode, NimNode) =
  doAssert cmd.len == 2
  expectKind(cmd[0], nnkIdent)
  result = (cmd[0], # leave cmd[0] as is, has to be valid integer expr
            cmd[1]) # identifier to use for loop

macro cnt(cmd: untyped, stmts: untyped): untyped =
  expectKind(cmd, nnkCommand)
  expectKind(stmts, nnkStmtList)
  let (iterVar, toIdx) = parseArgs(cmd)
  result = quote do:
    for `iterVar` in 1..`toIdx`:
      `stmts`
  echo result.repr

cnt j paramStr(1).parseInt:
    echo j, "- Give me some beer"

