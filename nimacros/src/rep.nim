# make APP=rep
# Based on a model by Juan Carlos Paco
import macros

macro iter(i:untyped, c1:untyped,
            c2:untyped, stm:untyped): untyped =
  result = newNimNode(nnkStmtList)  # creates an empty result
  var for_loop=
    newNimNode(nnkForStmt) # creates a for-loop
  for_loop.add(i) # adds index `i` to the for-loop

  var rng = # creates a range
    newNimNode(nnkInfix).add(ident("..")).add(c1,c2)
  for_loop.add(rng)  # inserts the range into for_loop
  let spc= newLit("- ") # Creates a space string Lit
  var wrt = newCall(ident("write"),ident("stdout"), i, spc)
  var stmList= newNimNode(nnkStmtList)
  stmList.add(wrt)
  for s in stm: stmList.add(s)
  for_loop.add(stmList)
  result.add(for_loop) # insert for_loop into result

iter(i, 0, 3):
  echo "Hello, world."
  echo "End"


