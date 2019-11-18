# File: web.nim
import strutils, os, strscans, unicode, uri
let input = open("rage.md")
let form = """
   <form name='form' method='get'>
       Visitor: <input type='type='text' name='$#'/>
    </form> <br/>
  """

echo "Content-type: text/html\n\n<html>"
echo """
  <head>
    <meta http-equiv= 'Content-type'
      content= 'text/html; charset=utf-8' />
  </head>
<body>  
"""

proc tl(input: string; match: var string, start: int): int =
  match = input[start .. input.high]
  result = max(1, input.len - start)

var html: string
for line in input.lines:
  if scanf(line, "## ${tl}", html): echo "<h2> $1 </h2>" % html 
  elif scanf(line, "# ${tl}", html): echo "<h1>$1</h1>" % html
  elif scanf(line, "in: ${tl}", html): echo form % html
  elif scanf(line, "${tl}", html): echo "$#<br/>" % html

let qs = getEnv("QUERY_STRING", "none")
if qs != "none" and qs.len > 0:
  let vs = open("visitors.txt", fmAppend)
  if scanf(qs, "N=${tl}", html):
     let n= "$#" % html
     if n != "" and not isSpace(n): write(vs, n.decodeUrl(true) & "\n")
  vs.close

let inputVisitors= open("visitors.txt")
for line in inputVisitors.lines: echo line&"<br/>"
inputVisitors.close
echo "</body></html>"
input.close

