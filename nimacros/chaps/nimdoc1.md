# Another computer language

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
  if paramCount() < 1: quit("Usage: " & paramStr(0) & " <filename.data>")
  let s = readFile(paramStr(1)).splitWhitespace.map(x => x.parseFloat)
  echo "Sum= ", s.foldl(a + b), " / Average= ", avg(s)

main()
```

(@readfile) Read and process a file

Let us find out how many students graduate from
medical schools in California. The `grad.data`
file gives the number of graduates from each
school. The `rd.nim` program prints the addition
and the average. Here is how to compile and run
the program of listing @readfile:

```
src> nim c -o:rd.x -d:release rd.nim  # Compile 
src> cat nums.data                    # Check the data
190   45 23 34 89 96 78
97 14 17 54 345 3 42

src> ./rd.x nums.data                 # Run the program
Sum= 1127.0 / Average= 80.5
```

\pagebreak
The predicate `paramCount() < 1` checks whether the file name is
present on the command line. If it is not, the program quits with
a request for the file name. In the snippet below, taken from the
application @readfile, the `paramStr(0)` string contains the
application name.

```
  if paramCount() < 1:
    quit("Usage: " & paramStr(0) & " <filename.data>")
```

The local variable `s` receives the result of a sequence of
operations on the file contents. The  `readFile(paramStr(1))`
operation reads the file whose name is on the command line.
The `nums.data` file contains space separated numbers that
`.splitWhitespace` parses and produces a sequence of strings.
Finally, `map(x => x.parseFloat)` transforms this sequence
into floating point numbers that `foldl(a+b)` adds up.
The `avg(xs: seq[float])` sums the floating point numbers
into the `result` variable and calculates the length of
the sequence into `n`. The average is `result/n`.

![](figs-prefix/bugcerto.jpg "Voyage to the moon"){width=250px}

The first computer was constructed by Konrad Zuse,
a German civil engineer, and his assistant,
Ms. Ursula Walk, née Hebekeuser. Ancient computers,
like those of Zuse and Walk, were based on relays.
These are bulky electrical devices, typically incorporating
an electromagnet, which is activated by a current
in one circuit to turn on or off another circuit.
Computers made of such a contrivance were enormous,
slow, and unreliable. Therefore, on September 9th, 1945,
a moth flew into one of the relays of the Harvard  Mark II
computer and jammed it. From that time on, *bug* became
the standard word to indicate an error that prevents
a computer from working as intended.

Due to bugs, compilers of languages like Nim and Haskell
frequently return error messages, instead of generating
code and running the corresponding programs. The Steel
Bank Common Lisp language does not interrupt code
generation when the compiler spots a bug, all the same
it does issue warnings that help find the problem before
the embarassment of failure being manifest on the client's
terminal.

