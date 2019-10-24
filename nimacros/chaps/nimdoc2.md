# Comma separated values

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

#[ 
   Compile:  nim c -d:release -o:csv.x --nimcache:lixo csv.nim
   src> cat csv.data
   190, 180, 170, 160, 120,  100
   100,90  

   src> ./csv.x csv.data
   Average= 138.75
]#
```

The program above calculate the average of comma separated values.
Everything that comes between `#[` and `]#` is comments. Therefore,
the comments are giving an example of how to compile and use the
program. Text that comes after `#` and the end of line is a comment
as well. This second kind of comment is used is very common in shell
commands.

The `split(Whitespace+{','})` operation splits a string with
values that can be separated by any combination of chars that
belong to the `Whitespace+{','}` set. Since `split` produces
empty `""` strings, the program applies `filter(x => x.len > 0)`
to the result, in order to eliminate zero-length strings from
the sequence.

## Iterators

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

#[
src> nim c -o:ird.x -d:release --nimcache:./lixo ird.nim
src> ./ird.x csv.data
138.75
]#
```

In the procedure that reads a file and splits it
into a sequence of `int`, the split function
generates empty strings at the end of the file
and possibly at the end of each line as well.
Therefore, I designed an iterator that feeds
a `for-loop` with  valid strings that can be
parsed to floats, which one can use to calculate
the average of a sequence of values.

In Nim, iterators are as easy to design as normal
functions. In fact, iterators are functions that
produce values more than once. They are defined like
procedures, but the keyword *iterator* replaces
the keyword *proc* that defines procedures. Another
difference between iterators and functions is that
an iterator uses the keyword *yield*, instead of
the keyword *return* to produce a value. In general,
iterators are used to feed a `for-loop` with a sequence
of values. After yielding a value, the iterator can
resume the computation to produce the next value. In
the example, the iterator `valid` yields a sequence of
strings that can be parsed to produce floating point
numbers.

