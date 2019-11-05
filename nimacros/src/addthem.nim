# File: addthem.nim
import os, strutils
{.compile: "addints.c".}
proc addTwoIntegers(a, b: cint): cint {.importc.}

when isMainModule:
  echo addTwoIntegers(paramStr(1).parseInt.cint, 7)
