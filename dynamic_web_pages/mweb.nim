# File: web.nim
import strutils, os, strscans, macros
let input = open("rage.md")

let form = """
<p> <form name='form' method='get'>
       <input type='type='text' name='Name'>
    </form>
</p>
  """

echo "Content-type: text/html\n\n<html>"
echo """
  <head>
    <meta http-equiv= 'Content-type'
      content= 'text/html; charset=utf-8' />
  </head>
"""
echo "<body>"

proc rest(input: string; match: var string, start: int): int =
  ## matches until the end of the string
  match = input[start .. input.high]
  # result is either 1 (string is empty) or the number of found chars
  result = max(1, input.len - start)

macro match(args, line: typed): untyped =
  ## match the `args` via `scanf` in `line`. `args` must be a `[]` of
  ## `(scanf string matcher, replacement string)` tuples, where the latter
  ## has to include a single `$#` to indicate the position of the replacement.
  ## The order of the `args` is important, since an if statement is built.
  let argImpl = args.getImpl
  expectKind argImpl, nnkBracket
  result = newStmtList()
  let matched = genSym(nskVar, "matched")
  result.add quote do:
    var `matched`: string
  var ifStmt = nnkIfStmt.newTree()
  for el in argImpl:
    expectKind el, nnkTupleConstr
    let toMatch = el[0]
    let toReplace = el[1]
    let ifBody = nnkStmtList.newTree(nnkCall.newTree(ident"echo",
                                                     nnkCall.newTree(ident"%",
                                                                     toReplace,
                                                                     matched)),
                                     nnkAsgn.newTree(matched, newLit("")))
    let ifCond = nnkCall.newTree(ident"scanf", line, toMatch, matched)
    ifStmt.add nnkElifBranch.newTree(ifCond, ifBody)
  result.add ifStmt
  echo result.repr

const h1title = ("# ${rest}", "<h2>$#</h2>")
const h2title = ("## ${rest}", "<h1>$#</h1>")
const elseLine = ("${rest}", "$#<br/>")
const replacements = [h1title, h2title, elseLine]
for line in input.lines:
  match(replacements, line)
  # produces:
  # var matched: string
  # if scanf("# ${rest}", line, matched):
  #   echo h1title[1] % matched
  # if scanf("## ${rest}", line, matched):
  #   echo h2title[1] % matched
  # if scanf("${rest}", line, matched):
  #   echo elseLine[1] % matched
echo form

let qs = getEnv("QUERY_STRING", "none").split({'+'}).join(" ")
if qs != "none" and qs.len > 0:
  let output = open("visitors.txt", fmAppend)
  write(output, qs&"\n")
  output.close

let inputVisitors= open("visitors.txt")
for line in inputVisitors.lines:
  match(replacements, line)
inputVisitors.close
echo "</body></html>"
input.close
