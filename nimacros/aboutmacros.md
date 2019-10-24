---
title: The Nim programming language
author: Eduardo Costa
geometry: margin=1in
fontsize: 12pt
numbersections: true
comment:
  pandoc -s nimdoc.md --syntax-definition nimrod.xml -o nimdoc.pdf

---

# Nim macros
I confess that Nim macros defeated me. My
expectations were that I would learn Nim
macros as easily as I had learned Lisp
macros, but no, Nim macros are tough. Then
I started to create theories about my
difficulty in learning Nim macros.

## Theory 1: Lisp chauvinism
Nim macros are easy, but I am so used to
Lisp macros that I cannot see the Nim
solution. It is easy to test this theory:
If I present the problem of learning Nim
and Lisp to young programmers, they will
learn Nim macros as easily as Lisp macros.

In fact, since I am a professor, it was
easy to perform an experiment -- I have
presented the challenge of learning Lisp
macros and Nim macros to students of
universities, where I have good contacts.
The subjects of this experiment already knew
Python, and Nim has a Python like syntax,
therefore, I believed that the students
would consider Nim much easier than Lisp.

I gave the students the choice of three books
from which to learn Lisp, *On Lisp*, by Paul
Graham, *Let Over Lambda*, by Doug Hoyte,
and *Land of Lisp*, by Conrad Barski.

After two weeks, most of the students were
creating Lisp macros for lazy evaluation,
loops of different kinds, reverse polish
notation, and so on. However, the students
had more difficulty with Nim macros than myself.

Therefore, I dropped the theory that I was
a Lisp chauvinist, and created another one...

## Theory 2: Great books
Lisp has great books in Chinese, English,
French and Russian that are distributed for
free throughout the Internet. Many students
told me that studying Lisp from a book written
by Svyatoslav Sergeevich Lavrov was inspiring,
since he is the very man, who was responsible
for the calculation of the trajectories of so
many spaceships at the dawn of astronautics,
such as Sputnik 1, Vostok 1 with Yuri Gagarin,
the Venera probes, Luna 3, etc. 

Besides the great book by Lavrov, *On Lisp* and
*Let Over Lambda* deal almost exclusively with
macros. The environment that the students use to
learn Lisp, I mean PTC, is very exciting too.
The PTC CAD/CAM program seems like Jarvis, the
butler from Iron Man, and you can use it to
design screws, gear cogs and whole machines,
if you are smart enough.

To test this second theory, I decided to write
a book about Nim macros, and see whether the
students could learn from my book. The problem is
that I don't really know Nim macros that well,
and my experience in programming is not as inspiring,
as is the case of Lavrov, or come to think of it
even Paul Graham. In fact, I was unable to write a
single interesting macro in Nim. My students did not
have any success in this endeavor either.  Thus, I
decided to write simple macros, and ask the Nim
community for help in improving them.

## Named Let
I will start with loop macros. The most desirable
goal would be to code something like the `named-let`
that is coded on four lines of page 45 in the book
*Let Over Lambda*, and works straight out of the box
in all implementations of Scheme. However, I will start
with a `repeat` macro. This is what I came up with:

```Nim

import macros, strutils, os

macro theMagicWord(statments: untyped): untyped =
    result = statments
    for st in statments:
          for node in st:
                if node.kind == nnkStrLit:
                     node.strVal = node.strVal & ", Please."

macro rpt(ix: untyped, cnt: int, statements: untyped)=
  quote do:
    for `ix` in 1..`cnt`:
      `statements`

rpt j, paramStr(1).parseInt :
  theMagicWord:
     echo j, "- Give me some bear"
     echo "Now"

```

As you noted from the above code, I read Steve
Kellock's article *Nim Language Highlights* and
I liked it. In the book that I am writing, I intend
to explain how the `rpt` macro works, and also how
to reason about macro coding in Nim. However, I must
confess that I still don't have any clear ideas of
how to design a Nim macro. I am not even sure
whether a multi-tool such as the  Lisp `loop` is
viable in Nim. To give an opinionated answer, I think
that Lisp SEXPR is very flexible, a ball of mud, in
the words of Joel Moses. I am afraid that I would not
be able to deal with Nim trees as easily as I can
shape, mold and cast Lisp SEXPRs.

Right now, I am accepting suggestions both on how to
code a `named-let` and also on how to improve
my `rpt` macro. For instance, I would like to write
something like the following:

```Nim
rpt paramStr(1).parseInt times -> j:
  theMagicWord:
     echo j, "- Give me some bear"
     echo "Now"
```

I am gladly awaiting your suggestions, and macro
examples. It is, from a didactic point of view,
desirable that the examples be limited to 5 lines,
as is the case of chapter 3 in *Let over Lambda*.

## RPN calculator

Listing @rpn shows an implementation of an rpn calculator.


```Nim
# nim c -d:release -o:rpn.x --nimcache:lixo rpn.nim
import os, strutils

type LL= ref object of RootObj
    car: float
    cdr: LL

template car(a:untyped) : untyped=
  if a == nil: quit("Empty stack")
  else: a.car

template `>>` (a,b:untyped): untyped= LL(car: a, cdr: b)

proc eval(x: string, s: var LL)=
  try: s= x.strip.parseFloat >> s
  except:
    case  x:
      of "+": s= (car s) + (car s.cdr) >> s.cdr.cdr
      of "x": s= (car s) * (car s.cdr) >> s.cdr.cdr
      of "/": s= (car s.cdr) / (car s) >> s.cdr.cdr
      of "-": s= (car s.cdr) - (car s) >> s.cdr.cdr
      of "neg": s= -(car s) >> s.cdr
      else: quit("Error in eval")

var stk: LL = nil
for i in 1 .. paramCount(): eval(paramStr(i), stk)
while stk != nil:
  echo stk.car
  stk= stk.cdr
  
#[
src> ./rpn.x 347 45 +
392.0
]#
```
(@rpn) Implementation of an rpn calculator

Before trying to understand the program of listing @rpn,
let us see how to use it. The program is an emulator of
the famous hp calculators. I ask your forbearance, for
I will make a partial transcription of the part of my
book, where I implement an HP 12C calculator. However,
I would appreciate if people in this forum could tell
me how to implement the `>>` and `car` templates with
macros. 

Here is the story of a Texan who went on vacation to
a beach in Mexico. While he was freely dallying with
the local beauties, unbeknownst to him a blackmailer
took some rather incriminating photos.

After a week long gallivanting, the Texan returns to his
ranch in a small town near Austin. Arriving at his door
shortly after is the blackmailer full of bad intentions.

Unaware of any malice, the Texan allows the so called
photographer to enter and sit in front of his desk.
Without delay, the blackmailer spread out a number of
photos on the desk, along with his demands: “For the
photo in front of the hotel, that will cost you $25320.00.
Well, the one on the beach that's got to be $ 56750.00.
Finally, this definitively I can't let go for less
than $136000.00.”

Once finished with his presentation, the blackmailer snaps
up the photos, and looks to the Texan with a sinister grin,
awaiting his reply.

Delighted with the selection of pictures, the Texan in an
elated voice says: “I thought I would have no recollection
of my wonderful time. I want 3 copies of the hotel shot,
half a dozen of the beach. And the last one, I need two
copies for myself, and please, send one to my ex-wife.
Make sure you leave me your contact details; I might need
some more. 

In order to calculate how much the Texan needs to pay his
supposed blackmailer, his bookkeeper needs to perform the
following operations: 

```
3×25320+6×56750+2×136000+136000 
```

Below, you can see how the Texan's bookkeeper calculates the
blackmailer's payment with the calculator from listing @rpn.

```
src> ./rpn.x 3 25320 x  6 56750 x + 3 136000 x +
824460.0
```


