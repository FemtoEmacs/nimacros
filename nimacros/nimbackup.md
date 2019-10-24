---
title: The Nim programming language
author: Eduardo Costa
geometry: margin=1in
fontsize: 12pt
numbersections: true
comment:
  pandoc -s nimdoc.md --syntax-definition nimrod.xml -o nimdoc.pdf

---
 
# Another computer language
Let us find out how many students graduate from
medical schools in California. The `grad.data`
file gives the number of graduates from each
school. The `rd.nim` program prints the addition
and the average.

```Nim
# nim c -d:release --nimcache:lixo -o:rd.x rd.nim
import os, strutils, sequtils, sugar
proc avg(xs: seq[float]): float =
  result= 0.0
  var n= 0.0
  for x in xs:
    result= result + x
    n= n+1.0
  result= result/n

proc main() =
  if paramCount() < 1:
    quit("Usage: " & paramStr(0) & " <filename.data>")
  let
    s = readFile(paramStr(1)).splitWhitespace.map(x => x.parseFloat)
  echo "Sum= ", s.foldl(a + b), " / Average= ", avg(s)

main()

#[ Compile and run:
src> nim c -o:rd.x -d:release --nimcache:lixo rd.nim
src> cat nums.data
190   45 23 34 89 96 78
97 14 17 54 345 3 42
src> ./rd.x nums.data
Sum= 1127.0 / Average= 80.5
]#
```

\pagebreak
One calls the application with a file name on the
command line, as shown below:

```
src> ./rd.x nums.data
```
The predicate `paramCount() < 1` checks whether
the file name is present on the command line.
If it is not, the program quits with a request
for the file name. The `paramStr(0)` string
contains the application name.

```
  if paramCount() < 1:
    quit("Usage: " & paramStr(0) & " <filename.data>")
```

The local variable `s` receive the result of a sequence of
operations on the file contents. The  `readFile(paramStr(1))`
operation reads the file whose name is on the command line.
The `nums.data` file contains space separated numbers that
`.splitWhitespace` parses and produces a sequence of strings.
Finally, `map(x => x.parseFloat)` transforms this sequence
into floating point numbers that `foldl(a+b)` adds up.
The `avg(xs: seq[float])` sums the floating point numbers
into the `result` variable and calculates the length of
the sequence into `n`. The average is `result/n`.


## Comma separated values
Let us calculate the average of comma separated values.

```Nim
# nim c -d:release -o:csv.x --nimcache:lixo csv.nim
import os, strutils, sequtils, sugar

proc main() =
  if paramCount() < 1: quit("Usage: " & paramStr(0) & "fname.data")
  let
    s = readFile(paramStr(1)).split(Whitespace+{','})
    xs= s.filter(x => x.len > 0).map(x => x.parseFloat)
  echo "Average= ", xs.foldl(a+b)/float(xs.len)

main()

#[ Compile:  nim c -d:release -o:csv.x --nimcache:lixo csv.nim
src> cat csv.data
190, 180, 170, 160, 120,  100
100,90  

src> ./csv.x csv.data
Average= 138.75
```

The `split(Whitespace+{','})` operation splits a string with
values that can be separated by any combination of chars that
belong to the `Whitespace+{','}` set. Since `split` produces
empty `""` strings, we applied `filter(x => x.len > 0)` to the
result, in order to eliminate zero-length strings from the
sequence.

## Iterators
In the program that reads a file and split it
into a sequence of int, the split function
generates empty strings at the end of the file
and possibily at the end of each line as well.
Therefore, I designed an iterator that feeds
a `for-loop` with  valid strings that can be
parsed to floats, wich one can use to calculate
the average of a sequece of values.

```Nim
# nim c -d:release -o:ird.x --nimcache:lixo ird.nim
import os, strutils

iterator valid[T](a: seq[T]): T=
  for x in a:
     if x.len != 0: yield x

proc avg(xs: seq[string]): float =
  result= 0.0
  var n= 0.0
  for x in valid(xs):
    n= n+1
    result= result+x.parseFloat
  result= result/n

proc main() =
  if paramCount() < 1: quit("Usage: " & paramStr(0) & " fname")
  let
    s = readFile(paramStr(1)).split(Whitespace+{','})
  echo avg(s)

main()

src> nim c -o:ird.x -d:release --nimcache:./lixo ird.nim
src> ./ird.x csv.data
138.75
```

In Nim, iterators are as easy to design as normal
functions. In fact, iterators are functions that
produce values more than once. They are defined like
procedures, but the keyword *iterator* replaces
the keyword *proc* that defines procedures. Another
difference between iterators and functions is that
an iterator uses the keyword *yield*, instead of
the keyword *return* to produce a value. In general,
iterators are used to feed a for-loop with a sequence
of values. After yielding a value, the iterator can
resume the computation to produce the next value. In
the example, the iterator `valid` yields a sequence of
strings that can be parsed to produce floating point
numbers.

## Exceptions
You will find `exceptions` in many languages, therefore I
believe that the program below will not pose difficulties.
The avg procedure does not try to eliminate invalid strings
from the sequence. Since the program is not sure that the
string represents a valid floating point number, it tries
to parse it. If the `avg` procedure fails to parse a string,
the error is captured in an exception section and discarded.

```Nim
# nim c -d:release -o:excrd.x --nimcache:lixo excrd.nim

import os, strutils, sequtils, sugar

proc main() =
  proc avg(xs: seq[string]): float=
     var sm, n = 0.0
     for i, x in xs:
       try:
          sm = sm + x.strip.parseFloat
          n= n + 1.0
       except: discard
       finally:
          result= sm/n

  if paramCount() < 1:
    quit("Usage: " & paramStr(0) & " filename")
  let
    xs = readFile(paramStr(1)).split(Whitespace+{','})
  echo avg(xs)

main()
  


#[
src> nim c -o:excrd.x -d:release --nimcache:lixo excrd.nim
src> ./excrd.x csv.data
138.75
]#  
```

In the program above, I defined the `avg` procedure
inside the `main` procedure, just to demonstrate that
this is possible.

The procedure `strip` eliminates blanks around the string,
before parsing it to floating point numbers. This is not
strictly necessary, but I did it just to be on the safe side.

## Ready
If you installed Nim and tested the programs on the previous
pages of this tutorial, you are ready for action.

![](figs-prefix/readyforaction.jpg "Voyage to the moon")

(@ready) You are ready for action

It seems that people prefer money to sex. After all,
almost everybody says no to sex on one occasion or
another. But I have never seen a single person
refusing money. Therefore, let us start this tutorial
with stories of people dealing with money.

## Pictures

Here is the story of a Texan who went on vacation
to a beach in Mexico. While he was freely dallying
with the local beauties, unbeknowest to him a
blackmailer took some rather incriminating photos.
After a week long gallivanting, the Texan returns
to his ranch in a small town near Austin. Arriving
at his door shortly after is the blackmailer full
of bad intentions.

Unaware of any malice, the Texan allows the so
called photographer to enter and sit in front of
his desk. Without delay, the blackmailer spread
out a number of photos on the desk, along with his
demands: “For the photo in front of the hotel, that
will cost you $25320.00. Well, the one on the beach
that's got to be $56750.00. Finally, this definitively
I can't let go for less than $136000.00.”

Once finished with his presentation, the blackmailer
snaps up the photos, and looks to the Texan with a
sinister grin, awaiting his reply.

Delighted with the selection of pics, the Texan
in an ellated voice says:

> “I thought I would have no recollection
of my wonderful time. I want 3 copies of
the hotel shot, half a dozen of the beach.
And the last one, I need two copies for myself,
and please, send one to my ex-wife. Make sure
you leave me your contact details; I might
need some more.”




