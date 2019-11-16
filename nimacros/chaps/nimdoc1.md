# State machines
My private library has many books in Ancient Greek,
Latin, German, Esperanto, French, Japanese, Chinese,
Guarany, Russian and other languages that I don't
speak. Even so, I read the first two pages of these
books, to know whether it was worthwhile to learn the
language and read until the end. War and Peace is
written in French and Russian, thus I read the French
part of the first page and put the book back on the
shelf, where it remained over many years as a feast for
cockroaches that ate the glue on the cover.

Keeping with my bad reading habits, I read only the first
page of Wittgenstein's Tratactus Logico-Philosophicus,
which has a title in Latin, but is written in German.
Here is the first line of the Tratactus:

1. Die Welt ist alles, was der Fall ist.
   - 1.1. Die Welt ist die Gesamtheit der Tatsachen, nicht der Dinge.

On the first line, an English speaker can recognize a
lot of words, for instance, *Welt* must mean *World*,
*alles* can be translated by *all* and *Fall* is *fall*.
There was that Roman deity, Fortune, who decided the
destiny of the World by throwing dice. It seems that
Wittgenstein is saying that the World is all that the
state of the Fortune's dice indicates that it is.

On the second line, Wittgenstein is saying that the
World is the totality of facts, not of things. Of course,
things do exist, but the World is something beyond a
set of things. What is the entity, which is beyond a mere
collection of things? Let us read a little further to
see if the philosopher sheds light on the subject.

> Was der Fall ist, die Tatsache, ist das Bestehen von
> Sachverhalten.

David Pears translates the above line as

> *What is a case -- a fact -- is  the existence of
> states of affairs.*

In Latin, the word *STATUS* (Romans used to write only
in uppercase letters) means the temporary attributes of
a person or thing. What is an attribute? It is the
position, station, place, posture, order, arrangement,
condition, characteristic, aspect, feature, quality or
trait that a thing can possess. An attribute has values,
for instance, the attribute *color* can have values such
as red, green, blue, yellow, etc. The *position* attribute
can be given by the values  of the Cartesian coordinates
of the object.

Computers are state machines, therefore they are good
for modeling the world and its evolution through change
of states. Computers themselves have registers, where they
can store the values of the attributes that the machine
represents. Computer programs abstract the registers into
variables. Therefore, a program represents states by sets
of values for its variables. To understand this point, let
us consider a concrete problem.

```Nim
# File: zeller.nim
import os, strutils

proc roman_order(m : int): int=
  let wm= (14 - m) div 12
  result= m + wm*12 - 2

proc zr(y:int, m:int, day:int): int=
  let
    roman_month= roman_order(m)
    roman_year= y - (14 - m) div 12
    century=  roman_year div 100
    decade= roman_year mod 100
  result= (day + (13*roman_month - 1) div 5 +
                 decade + decade div 4 +
                 century div 4 +
                 century * -2) mod 7

proc main () =
  let
    year = paramStr(1).parseInt
    month = paramStr(2).parseInt
    day = paramStr(3).parseInt
  echo zr(year, month, day)

main()
```

(@zeller) Day of the week by Zeller's congruence

You certainly know that the word `December` means
the tenth month; it comes from the Latin word for
ten, as attested in words such as:

- decimal -- base ten.
- decimeter -- tenth part of a meter.
- decimate -- the killing of every tenth Roman soldier
              that performed badly in battle.

October is named after the Latin numeral for *eighth*.
In fact, the radical *Oct-* can be translated as *eight*,
like in *octave*, *octal*, and *octagon*. One could
continue   with this exercise, placing September in the
seventh, and November in the ninth position in the
sequence of months. But everybody and his brother know
that December is the twelfth, and that October is the
tenth month of the year. Why did the Romans give
misleading  names to these months?

Rome was purportedly founded by Romulus, who designed a
calendar. March was the first month of the year in the
Romulus calendar.  In order to get acquainted with
programming and the accompanying concepts, let us follow
the Canadian programmer Nia Vardalos, while she explores
the Nim programming language and calendar calculations.

If Nia wants the order for a given month in this mythical
calendar created by Romulus, she must subtract 2 from the
order in the Gregorian calendar, which happens to be in
current use in the Western World since it was instituted by
Pope Gregory XIII in 1582. After the subtraction, September
becomes the seventh month; October, the eight; November,
the ninth and December, therefore, the tenth month.

Farming and plunder were the main occupations of the Romans,
and since winter is not the ideal season for either of these
activities, the Romans did not care much for January and
February. However, Sosigenes of Alexandria, at the request
of Cleopatra and Julius Cæsar, designed the Julian calendar,
where January and February, the two deep winter months, appear
in  positions 1 and 2 respectively. Therefore, a need for a
formula that converts from the modern month numbering to the
old sequence has arisen. In listing @zeller, this is done
by the following algorithm:

```Nim

proc roman_order(m : int): int=
  let wm= (14 - m) div 12
  result= m + wm*12 - 2

```

In the above formula, the variable `wm` will pick the value 1
for months 1 and 2, and 0 for months from 3 to 12. In fact,
for months from 3 to 12, `(14-m)` produces a number less
than 12, and `(14-m) div 12` is equal to 0. Therefore, the
state of the program for all months from March through December
is given by `wm=0` and `result=m-2`. When the variable `wm=0`,
the expression to calculate `result`  is reduced from
`result=m+wm×12-2` to `result=m-2`. This means that March
will become the Roman month 1, and December will become the
Roman month 10.

The variable `wm` models the state of the world for the winter
months. By the way, `wm` stands for *winter months*. Since
January is month 1, and February is month 2 in the Gregorian
calendar, `wm` is equal to 1 for these two winter months. In the
case of January, the state is given by: `m=1`, `wm=1`, `result=11`.
For February, the state becomes `m=2`, `wm=1`, `result=12`.


The program of the listing @zeller calculates the day of the week
through Zeller's congruence. In the procedure `zr(y, m, day)`,
the let-statement binds values to the following state variables:
`roman_month`, `roman_year`, `century` and `decade`. The listing
@zeller shows that a state variable avoids recalculating values
that appear more than once in a program. This is the case of
`roman_year`, which appears four times in the `zr(y,m,day)`
procedure. Besides this, by identifying important subexpressions
with meaningful names, the program becomes clearer and cleaner.

## Compile and run

After compiling the program of listing @zeller, one can calculate
the day of the week as a number between 0 and 6, which correspond to
Sunday, Monday, Tuesday, Wednesday, Thursday, Friday and Saturday.
For the time being, you do not need to worry about compilation
and running a program on the terminal. This book dedicates a whole chapter to the use of a text terminal. In any case, here is an example
of running the zeller congruence:

```Shell
› nim c -o:zeller.x -d:release --hints:off --nimcache:xx zeller.nim
CC: zeller.nim

› ./zeller.x 2016 8 31
3

```

This means that August 31 of 2016 fell on a Wednesday. 


## Sequence of statement
In linguistics, a statement is a declarative sentence that
describes a state or a state variable. In a program, one
may need a sequence of statements to determine all state
variables. In the programming language Nim, a sequence of
statements is indicated by indentation, i.e., all statements
that start at the same column belong to the same sequence.

## Procedures

In computer programming, a procedure is a sequence of
statements that isolates and determines a state. In Nim,
the procedure can cause change of state by performing
destructive assignment into variables introduced by the
key word `var`, but there is no way of changing the
value of variables introduced by the keyword `let`, such
as the variables that appear in listing @zeller.

## How to repeat a sequence of statements

During a programmer's life, he or she may need to repeat a
sequence of statements to generate a succession of steps
that will approach an end state or value. This repetition
process is called iteration after the Latin word for path.

Leonardo Bigollo Pisano, a.k.a. Fibonacci, was speculating
on how fast the reproduction of rabbits would be. His breeding
of rabbits has the interesting properties of mating at the
age of one month, thus, at the end of her second month, the
female produces a new pair of rabbits, a male and a female.
Then she keeps producing two babies a month for one year.

Fibonacci concluded that the number A~n~ of adult pairs
in a given month is equal to the total number R~n-1~
of rabbits, both babies and adults, from the previous month.
The clever fellow also perceived that, since each adult
pair produces two babies a month, the number of baby
pairs in a given month is the number of adult pairs from
the previous month, which is the total number of rabbits from
two months before. The total number of rabbit pairs, that
is adults plus babies, in any given month is the sum of the
pairs from the previous two months.

```Nim
# File: iterfib.nim
import os, strutils

proc fib(n: int): int =
  var (r1, r2) = (2, 1)
  for i in 2..n:
    (r1, r2) = (r1+r2, r1)
  result= r1

echo fib(paramStr(1).parseInt)
```

In the above program, the iteration is controlled by the
for-loop, that repeats a change of state over generations
from 2 through `n` of rabbits. Here is how the program is
compiled and executed:

```
› nim c --nimcache:xx -o:rabbits.x -d:release --hints:off iterfib.nim
› ./rabbits.x 5
13
```

## Recursion
Another way to discover the number of pairs in the previous
generation is to sum the number of pairs from three generations
ago to the number of pairs from two generations ago. This reasoning
does nothing more than apply the rule of finding the total number
of pairs in the present generation over the previous generation.
Here is a program that uses this idea:

```Nim
#› nim c --nimcache:xx -o:recfib.x -d:danger --hints:off recfib.nim
import os, strutils
proc fib(n: int): int =
  if n<2: result= n+1
  elif n<3: result= fib(n-1)+fib(n-2)
  else: result= fib(n-3)+fib(n-2)+fib(n-2)

echo fib(paramStr(1).parseInt)
```

(@recfib) Recursive Fibonacci function

The program of listing @recfib has many novelties. The first one is
the conditional execution of a sequence of statements. For instance, `result=n+1` sets `result` to `n+1`, but only if the condition `n<2`
is met. On the same token, `result=fib(n-1)+fib(n-2)` sets `result`
to `fib(n-1)+fib(n-2)`, if `n<3`.

However, the strangest feature of listing @recfib, is the
use of the `fib` function in the definition of `fib`. In
other words, the definition of `fib` calls itself. When such
a thing happens, computer scientists say that the definition
is recursive.

Typically a recursive definition has two kinds of conditions,
which in Nim are introduced by the if-statement:

- Trivial conditions, which can be resolved using primitive operations.
- General conditions, which can be broken down into simpler cases.

In listing @recfib, the trivial condition is --

+ `if n<2: result=n+1`

The general conditions are introduced by the `elif` and `else`
clauses for rewriting the expression `fib(n)` into one of
the following expressions:

```Nim
elif n<3: result= fib(n-1)+fib(n-2)
else: result= fib(n-3)+fib(n-2)+fib(n-2)
```

Where each occurrence of a call to `fib` is closer to the trivial
case than `fib(n)`, which was the original call.

The mathematician Peano invented a very interesting axiomatic
theory for natural numbers, that can be summarized thus:

1. Zero is a natural number.
2. Every natural number has a successor: The successor of 0 is 1, the
successor of 1 is 2, the successor of 2 is 3, and so on.
3. If a property is true for zero and, after assuming that it is true for n, you prove that it is true for n+1, then it is true for any natural number.

Did you get the idea? For this very idea can be applied to many other
situations, even in programming a computer.

Luciano Lima and Roger Alan think that it is very important to
reproduce Peano's theory in the Latin original. However, I
decided against meeting their demands for many reasons. In his
book, Arithmetices Principia, Peano adopted a notation that is
beyond the reach of most readers. Besides this, the 1889 edition
by the Fratres Bocca has many typos that I need to fix before
considering it for inclusion in this book.

Sergio Teixeira and Stephanie Bourdieu said that my implementation
of the Fibonacci procedure was not faithful to the 1228 edition of
the Liber Abaci. I changed the algorithms as recommended by them,
and also reproduced the fable of the 377 rabbits that appear in
chapter 12 of Fibonacci's book. 

Readers who do not know Latin, or are not interested in Fibonacci's
original work, can skip the rest of this chapter without any loss of
important information.

#### Liber Abaci -- Chapter XII: The Fable of the Rabbits {-#LiberAbaci}

A certain man keeps one pair of rabbits in an enclosed place.
This man wishes to know how many rabbits will be generated by
the original pair in a period of one year. It is the nature of
this breed of rabbits in a single month to bear another pair,
and in the second month those born to bear also.

Since the individuals of the  first pair of rabbits are adults,
in the first month, they will bear a pair of kittens, therefore
the number of animals will double; so, there will be two pairs
in one month. One of these, namely the first, bears in the
second month, and thus there are in the second month 3 pairs;
of these in one month two are pregnant, and in the third month
2 pairs of rabbits are born, and thus there are 5 pairs in the
month; in this month 3 pairs are pregnant, and in the fourth
month there are 8 pairs, of which 5 pairs bear another 5 pairs;
these are added to the 8 pairs making 13 pairs in the fifth
month; these 5 pairs that are born in this month do not mate in
this month, but another 8 pairs are pregnant, and thus there are
in the sixth month 21 pairs; to these are added the 13 pairs
that are born in the seventh month; there will be 34 pairs in this
month; to this are added the 21 pairs that are born in the eighth
month; there will be 55 pairs in this month; to these are added
the 34 pairs that are born in the ninth month; there will be 89
pairs in this month; to these are added again the 55 pairs that
are born in the tenth month; there will be 144 pairs in this month;
to these are added again the 89 pairs that are born in the eleventh
month; there will be 233 pairs in this month.

To these are still added the 144 pairs that are born in the last
month; there will be 377 pairs, and this many pairs are produced
from the aforementioned pair of rabbits in the enclosed place at
the end of the one year.

You can indeed see in the margin how we operated, namely that we
added the first number to the second, namely the 1 to the 2, and
the second to the third, and the third to the fourth, and the
fourth to the fifth, and thus one after another until we added the
tenth to the eleventh, namely the 144 to the 233, and we had the
total sum of rabbits, i.e. 377. Thus, you can systematically find
the number of rabbits for an indeterminate  number of months. 

#### Liber Abaci -- Capitulum XII: Fabula Cuniculorim {-#Liber}

Quot paria coniculorum in uno anno ex uno pario germinentur?

Quidam posuit unum par cuniculorum in quodam loco, qui erat
undique pariete circundatus, ut sciret, quot ex eo paria
germinarentur in uno anno: cum natura eorum sit per singulum
mensem aliud par germinare; et in secundo mense ab eorum
nativitate germinant.

Quia suprascriptum par in primo mense germinat, duplicabis ipsum,
erunt paria duo in uno mense. Ex quibus unum, silicet primum,
in secundo mense geminat; et sic sunt in secundo mense paria 3;
ex quibus in uno mense duo pregnantur; et geminantur in tercio
mense paria 2 coniculorum; et sic sunt paria 5 in ipso mense;
ex quibus in ipso pregnantur paria 3; et sunt in quarto mense
paria 8; ex quibus paria 5 geminant alia paria 5: quibus additis
cum pariis 8, faciunt paria 13 in quinto mense; ex quibus paria 5,
que geminata fuerunt in ipso mense, non concipiunt in ipso mense,
sed alia 8 paria pregnantur; et sic sunt in sexto mense paria 21;
cum quibus additis parijs 13, que geminantur in septimo, erunt in
ipso paria 34, cum quibus additis parijs 21, que geminantur in
octavo mense, erunt in ipso paria 55; cum quibus additis parijs 34,
que geminantur in nono mense, erunt in ipso paria 89; cum quibus
additis rursum parijs 55, que geminantur in decimo, erunt in ipso
paria 144; cum quibus additis rursum parijs 89, que geminantur in
undecimo mense, erunt in ipso paria 233. Cum quibus etiam additis
parijs 144, que geminantur in ultimo mense, erunt paria 377,
et tot paria peperit suprascriptum par in prefato loco in capite
unius anni. Potes enim videre in hac margine, qualiter hoc operati
fuimus, scilicet quod iunximus primum numerum cum secundo,
videlicet 1 cum 2; et secundum cum tercio; et tercium cum quarto;
et quartum cum quinto, et sic deinceps, donec iunximus decimum
cum undecimo, videlicet 144 cum 233; et habuimus suprascriptorum
cuniculorum summam, videlicet 377; et sic posses facere per ordinem
de infinitis numeris mensibus.

The farmer of Fibonacci's fable starts with a pair of addult
rabbits. Therefore, at the end of month 1, there were two pairs
of rabbits. In the instant zero of the experiment there was
only the original pair. Therefore, in listing @recfib, one has
the following clause for `n<2`:

```Nim
  if n<2: result= n+1
```

Since in the most general clause Stephanie needed three
generations of rabbits, she added a clause for the second
month, to wit:

```Nim
  elif n<3: result= fib(n-1)+fib(n-2)
```

From the second month onward Stephanie can use the most
general clause:

```Nim
  else: result= fib(n-3)+fib(n-2)+fib(n-2)
```

In general, recursive calculation of Fibonacci's function
is very inefficient, and is often used in benchmarks.
However, good compilers succeed to optimize the recursion
away, therefore the algorithm given by listing @recfib is
very fast.


# Shell

Nia, a young Greek woman, has an account on a well-known social
network. She visits her friends' postings on a daily basis, and
when she finds an interesting picture or video, she presses
the *Like*-button. However, when she needs to discuss her upcoming
holidays on the Saba Island with her Argentinian boyfriend, she uses
the live chat box. After all, hitting buttons and icons offers only
a very limited interaction tool, and does not produce a highly
detailed level of information that is possible in a chat box.

Using a chat service needs to be very easy and fun, otherwise
teenagers would be doing something else. I am telling you this,
because there are two ways of commanding the operating system (OS)
that the computer uses to control mouse, keyboard, mass storage
devices, etc. The first is called Graphical User Interface (GUI)
and consists of moving a mouse and clicking over a menu option
or an icon, such as the `Like` button. As previously mentioned,
a GUI often does not generate adequate information for making a
request to the OS. In addition, finding the right object to press
can become difficult in a labyrinth of menu options.

The other method of interacting with the computer is known as
Shell, and is similar to a chat service. On a Shell interface,
Nia issues instructions that the operating system (OS) answers
by fulfilling the assigned tasks. The language that Nia uses
to chat with the OS is called *bash*. Another option is *zsh*,
but it is so similar to *bash* that it does not require a separate
tutorial. Languages such as *bash* and *zsh* have commands to go
through folders, browser files, create new directories, copy
objects from one place to the other, configure the machine,
install applications, change the permissions of a file, etc.
When accessing the OS through a text-based terminal, a shell
language is the main way of executing programs and doing work
on a computer.

In order not to scare off the feeble-minded, many operating
systems hide access to the text terminal. In some distribution
of Linux, you need to maintain the `Alt` key down, then press
the `F2` key to open a dialog box, where you must type the
name of the terminal you want to open. If you are really lucky,
you may find the icon of the terminal  on the tool bar.
If the method for opening the text terminal is not so obvious,
you should ask for help from a student majoring in Computer Science.

## The prompt {-#The}
The shell prompt is where one types commands. The prompt
has different aspects, depending on the configuration of
the terminal. In Nia's machine, it looks something like
this:

```Shell
~$ _
```

Files are stored in folders. Typically, the prompt shows the
folder where the user is currently working. The main duty of
the operating system is to maintain the content of the mass
storage devices in a tree structure of files and folders.
Folders are also called *directories*, and like physical
folders or cabinets, they organize files. A folder can be put
inside another folder. In a given machine, there is a folder
reserved for duties carried out by the administrator. This
special folder is called `HOME` or personal directory.

Now, let us learn a few commands to control the terminal
and get things moving.

```bash
nim/nimacros# cd ~
~$ mkdir wrk
~$ cd wrk
~/wrk$ cat <<EOF > hi.nim
heredoc> import os
heredoc> stdout.writeLine "Hello ", paramStr(1)
heredoc> EOF
~/wrk$ ls
hi.nim
~/wrk$ cat hi.nim
import os
stdout.writeLine "Hello ", paramStr(1)
```

The first command in the above dialog is `cd ~` that changes
the prompt to the `HOME` folder, which is represented by a tilde.
The second command, `mkdir wrk`, creates the `wrk` folder
inside the `HOME` directory. The `cd wrk` statement puts
the cursor prompt inside the newly created `wrk` directory. 

The `cat <<EOF > hi.nim` command sends to the `hi.nim` file
a text that terminates with the `EOF` token. The terminating
token does not need to be `EOF`, in fact, you can choose anything
to close the input. The `<<EOF` is a kind of arrow pointing
to `cat`, in order to indicate that the input will be
delivered to the `cat` command. By analogy, `>` points to
file `hi.nim`, which is the destination of the `cat` output.

In general, people use `cat` for printing the contents of a file,
exactly as Nia did when she issued the `cat hi.nim` command in
the above example. However, I could not resist the idea of
providing you with a more interesting use for the `cat` command.

Finally, in the above example, the `ls` command lists the files,
which are stored inside the `wrk` folder. The combination of `ls`
and `cd` permits the browsing of the tree of files and folders,
therefore one must learn how to use it well, which will be taught
in the following pages.

### pwd {-#pwd} 
The `pwd` command informs the cursor prompt position in the
file tree. A folder can be placed inside another folder.
For example, in a Macintosh, the `HOME` folder is inside
the `/Users` directory, therefore, if Nia issues the `pwd`
command from her `HOME` folder, she obtains the result
that is shown below.

```Shell
~$ set -k
~$ pwd      # shows the current folder.
Users/nia
```

One uses a path to identify a nest of folders. In a path,
a sub-folder is separated from the parent folder by a slash
bar. If one needs to know the path to the current folder,
there is the `pwd` command. 

When Nia issues a command, she may add comments to it,
so her boyfriend that does not know the Bourne-again
shell (*bash*) can understand what is going on and learn
something in the process. Just like in Nim, comments are
prefixed with the `#` hash char, as you can see in the above
chat. Therefore, when the computer sees a `#` hash char,
it ignores everything to the end of the line.

In the *Z shell* (*zsh*), it is necessary to use the `set -k`
command to activate comments, but in the *bash* shell, comments
are always active by default.


### mkdir wrk {-#mkdir}
The command **mkdir wrk** creates a `wrk` folder inside
the current directory, where `wrk` can be replaced with
any other name. Therefore, if Nia issues the `mkdir wrk`
command from her `HOME` directory, she creates a new
folder with the `Users/nia/wrk` path.

### cd wrk {-#cd} 
One can use the `cd <folder name>` command to enter the named
directory. The `cd ..`  command takes Nia to the parent of the
current directory. You also learned that `ch ~` sends the prompt
to the `HOME` directory. Thanks to the `cd` command, one can
navigate through the tree of folders and directories.

### Tab {-#Tab}
If you want to go to a given directory, type part of the
directory path, and then press *Tab*. The shell will complete the
folder name for you.


### Home directory {-#Home}
A `~` tilde represents the home directory. For instance, `cd ~`
will send Nia to her personal folder. The `cd $HOME` has exactly
the same effect.

```Shell
~/wrk$ ls
hi.nim
~/wrk$ cd ~
~$ cd wrk
~/wrk$ cd $HOME
~$
```

### echo and cat {-#echo}
The `echo` command prints its arguments. Therefore, `echo $HOME`
prints the contents of the `HOME` environment variable. Environment
variables store the terminal configuration. For instance, the `HOME`
variable contains the user's personal directory identifier. One
needs to prefix environment variables with the `$` char to access
their contents:

```Shell
~$ echo $HOME
/Users/nia
```

The instruction `echo "import os, strutils" > fb.nim` creates
a `fb.nim` file and writes the argument of the `echo` command
there. If the file exists, this command supersedes it.

The command `echo "# Fibonacci function" >> ifib.nim` appends a
string to a text file. It does not erase the previous content
of the `ifib.nim` file. Of course, you should replace the
string or the file name, as necessity dictates.

```Shell
~$ cd wrk      # transfer action to the wrk file
~/wrk$ echo 'import os, strutils\n' > ifib.nim
~/wrk$ {
cursh> echo 'proc fib(n: int): int ='
cursh> echo '   var (r1, r2) = (2, 1)'
cursh> } >> ifib.nim
~/mwrk$ ls
hi.nim ifib.nim
~/wrk$ cat ifib.nim
import os, strutils

proc fib(n: int): int =
   var (r1, r2) = (2, 1)
```

The above example shows that you can use braces to create
a sequence of `echo` commands. The `cat ifib.nim` prints
the contents of file `ifib.nim`,  as you learned before.

### Extended example of cat {-#Extended}
Below you will find an extended example of a chat between Nia
and *zsh* with many examples of `cat` and `echo`. The `\n`
directive in the string `import os, strutils\n` provokes a
line break. Note that Nia replaced `EOF` with `EOT` just to
show that it can be done.

```bash
~$ cd wrk      # transfer action to the wrk file
~/wrk$ echo 'import os, strutils\n' > ifib.nim
~/wrk$ {
cursh> echo 'proc fib(n: int): int ='
cursh> echo '   var (r1, r2) = (2, 1)'
cursh> } >> ifib.nim
~/wrk$ ls
hi.nim   ifib.nim
~/wrk$ cat <<EOT >> ifib.nim
heredoc>    for i in 2..n:
heredoc>       (r1, r2) = (r1+r2, r1)
heredoc>    result= r1
heredoc>
heredoc> echo fib(paramStr(1).parseInt)
heredoc> EOT
~/wrk$ cat ifib.nim
import os, strutils

proc fib(n: int): int =
   var (r1, r2) = (2, 1)
   for i in 2..n:
      (r1, r2) = (r1+r2, r1)
   result= r1

echo fib(paramStr(1).parseInt)
```

### ls {-#ls} 
By convention, a file name has two parts, the *id* and the
*extension*. The id is separated from the extension by a dot.
The `ls` command lists all files and sub-folders present in
the current folder. The `ls *.nim` prints only files with
the `.txt` extension.

The `*.nim` pattern is called wild card. In a
wild card, the `*` asterisk matches any sequence of chars,
while the `?` interrogation mark matches a single char.
The command `ls -lia *.nim` prints detailed information
about the `.nim` files, like date of creation, size, etc.

```bash
~/wrk$ ls -lia *.nim
1291 -rw-r--r--  1 ed  staff   49 Nov  2 08:44 hi.nim
1292 -rw-r--r--  1 ed  staff  163 Nov  2 10:44 ifib.nim
```

Files starting with a dot are called hidden files, due to
the fact that the `ls` command does not normally show them.
All the same, the `ls -a` option includes the hidden files
in the listing.

In the preceding examples, the first character in each list
entry is either a dash `(-)` or the letter `d`. A dash `(-)`
indicates that the file is a regular file. The letter `d`
indicates that the entry is a folder. A special file type
that might appear in a `ls -la` command is the `symlink`.
It begins with a lowercase `l`, and points to another
location in the file system. Directly after the file
classification comes the permissions, represented by the
following letters:

+ `r` -- read permission.
+ `w` -- write permission.
+ `x` -- execute permission.

### cp {-#cp}
The `cp ifib.nim fib.nim` makes a copy of a file. You can
copy a whole directory with the `-rf` options, as shown
below.

```zsh
~/wrk$ ls
hi.nim   ifib.nim
~/wrk$ cp ifib.nim fib.nim
~/wrk$ ls
fib.nim  hi.nim   ifib.nim
~/wrk$ cd ..
~$ cp -rf wrk discard
~$ cd discard
~/discard$ ls
fib.nim  hi.nim   ifib.nim
```

### rm {-#rm}
The `rm ifb.nim` command removes a file. The `-rf` option 
removes a whole folder.

```bash
~/discard$ ls
fib.nim  hi.nim   ifib.nim
~/discard$ ls
fib.nim  hi.nim   ifib.nim
~/discard$ rm ifib.nim
~/discard$ ls
fib.nim hi.nim
~/discard$ cd ..
~$ rm -rf discard
~$ ls discard
ls: discard: No such file or directory
```

### mv {-#mv}
The `mv wrk work` command changes the name of a file or
folder, or even permits the moving of a file or folder
to another location. By the way, the `cp bkp/ifib.nim .`
copies the `ifib.nim` file to the current directory,
which is represented by a `(.)` dot. You can use
a `(.)` dot to represent the current directory with any
shell command.

```zsh
~# mv wrk work
~$ cd work
~/work$ ls
fib.nim  hi.nim   ifib.nim
~/work$ mkdir bkp
~/work$ mv ifib.nim bkp
~/work$ ls
bkp     fib.nim hi.nim
~/work$ ls bkp
ifib.nim
~/work$ cp bkp/ifib.nim .
~/work$ ls
bkp      fib.nim  hi.nim   ifib.nim
```

### Pen drive {-#Pen}
In most Linux distributions, the pen drive is seen as
a folder inside the `/media/nia/` directory, where you
should replace `nia` with your user name. However, in
the Macintosh, the pen drive appears at the `/Volume/`
folder. The commands `cp`, `rm` and `ls` see the pen
drive as a normal folder.

### Nim distribution package {-#Nim}

The distribution package for a piece of software such
as Nim is called archive, since it contains many files
stored together in a compact way, that you will need to
decompress and extract.

A popular tool for decompressing an archive is `tar` that
accepts files with extensions `.tar.xz`, `.bz2` or `tar.xz`
depending on the method of compression. Extraction is
performed by the `tar` application.

You will learn in this book that it is impossible to write
down all details of a craft. For becoming really proficient,
you need practice. In any case, I will provide some guidance
on the installation of the Nim compiler, but you will learn
to get the thing done if you put in some efforts of your own.
Ask for help from a computer science major, if you think
that the task is above your station.

You should search the Internet for the Nim language compiler
and download it. Then, extract, build and install the
distribution, as shown below.

To protect you against malware attacks, one needs
a password to write into the folders where critical
applications are installed. The `sudo` tool will
ask you for a password. If you type the correct password,
the `install.sh` script will be granted the permission to
install Nim in your computer.

```bash
~$ mkdir source
~$ cd source
~/source$ mv ~/Downloads/nim-x.y.z-os.tar.xz .
~/source$ tar xfJ nim-x.y.z-os.tar.xz
~/source$ cd nim-x.y.z
source/nim-x.y.z$ ls *.sh
build.sh     deinstall.sh install.sh
source/nim-x.y.z$ ./build.sh
source/nim-x.y.z$ sudo ./install.sh /usr/local/bin
```

Finally, you should test the installation with a
small program, as shown in the shell chat below. 
During the process of compilation, Nim creates
auxiliary files in the folder indicated by the
`--nimcache` option. I usually place these files
in the `xx` folder, which I remove to liberate
space in my machine.

```bash
source/nim-1.0.3$ cd ..
~/source$ mkdir tests
~/source$ cd tests
source/tests$ cat <<EOT > hi.nim
heredoc> import os
heredoc>
heredoc> stdout.writeLine "Hello ", paramStr(1)
heredoc> EOT
source/tests$ nim c -o:hi.x -d:release --hints:off --nimcache:xx hi.nim
CC: stdlib_io.nim
CC: stdlib_system.nim
CC: stdlib_posix.nim
CC: stdlib_times.nim
CC: stdlib_os.nim
CC: hi.nim
source/tests$ ./hi.x Ed
Hello Ed
source/tests$ ls
hi.nim hi.x   xx
source/tests$ rm -rf xx
```

# Emacs / lem

You can create source files by using the `cat` command.
However, for serious work, you need a text editor such
as lem, which is a clone of Emacs written in the Common
Lisp programming language. I will not try to explain how
to install lem, since the procedure changes over time and
from machine to machine. Therefore, search the web for
adequate binaries and instruction on how to install the
thing on your computer.

In the following cheat sheet for lem, `C-` is the `Ctrl` key, `M-`
denotes the `Alt` key, $\kappa$ can be any key, and `Spc`
represents the space bar. Thus, `C-`$\kappa$ means: Press and
release the `Ctrl` key and the $\kappa$ key simultaneously.

+ `C-s` -- search for a string of text. Press `C-s`, then type in
the text you  want to find
+ `C-s` again -- After the first occurrence, press `C-s` again 
to find other text instances
+ C-r -- reverse search 
+ `C-k` -- kill the text from the cursor, until the end of the line
+ `C-h` -- backspace: erase the char before the cursor and move backwards
+ `C-d` -- delete char under the cursor 
+ `C-Spc` then move the cursor -- select a region
+ `M-w` -- save selected region in the kill ring
+ `C-w` -- kill region, but save its contents in the kill ring
+ `C-y` -- insert killed/saved region at current cursor position
+ `C-g` -- cancel minibuffer reading
+ `C-a` -- go to beginning of line
+ `C-e` -- go to end of line
+ `C-/` -- undo
+ `INS` -- toggle overwrite mode
+ `C-b` -- move back one character
+ `C-f` -- move forward one character
+ `C-n` -- move cursor to the next line
+ `C-p` -- move cursor to the previous line
+ ←↑↓→ -- the arrow keys also move the cursor

### Ctrl-x commands {-#Ctrl-x}


The convention `C-x C-κ` means that you should keep
the `Ctrl` key down and press `x` and `κ` in sequence.
You must try to issue the commands in a way that is
ergonomic and comfortable. Keep the `Ctrl` key pressed
with the index finger of the left hand, and use the
index finger of the right hand to press the keys `x`
and `κ`, one after the other.

+ `C-x C-f` -- open a file into a new buffer
+ `C-x C-w` -- write file with new name
+ `C-x C-s` -- save the current file
+ `C-x C-c` -- exit the lem source editor
+ `C-x C-i` -- insert file at current cursor position

The `C-x ?` command --  describes a key stroke. Press
the `Ctrl` key and the `x` key at the same time, release
both keys, then press the `?` question mark. The one-line
buffer at the bottom of the page is called the minibuffer.
The command `C-x C-f` that finds a file reads the name of
the file from the minibuffer. This time, the minibuffer will
prompt you with the `describe-key` invitation. If you type
`C-x C-f`, the following description shows up:

- `describe-key: C-x C-f find-file`

The `C-x @` command -- pipes a shell instruction.
Keep the `Ctrl` key down, then press the `x` key.
Release both keys, then press the `@` key. The
lem editor will prompt for a shell command. Type
`ls`, for instance. It will open a temporary buffer
and show a list of file names.  There are many commands
that read information from the minibuffer:

+ `C-x C-f` -- retrieves the file you want to open from the minibuffer
+ `C-x C-s` -- reads the text sample you search for from the minibuffer
+ `C-x C-i` -- in the minibuffer, type a file name to insert at current
               cursor position


You must type `C-g`, whenever you want to cancel any
command that needs to read a complement from the minibuffer.

### Window commands {-#Window}

One can have more than one window on the screen at any given moment.
In the list below, you will find commands that deal with this situation.
In commands of the form `C-x κ` -- keep the `Ctrl` key down and
press `x`, then release both keys and hit the `κ` key. 

+ `C-x b` -- next buffer 
+ `C-x C-b` -- list buffers available
+ `C-x k` -- kill current buffer
+ `C-x 2` -- split window into cursor window and other window
+ `C-x o` -- jump to the other window
+ `C-x 1` -- close the other window
+ `C-x 0` -- close the cursor window

You can maintain many files open at the same time. I mean, when
you open a new file with the `C-x C-f` command, the buffer on
which you were working is not discarded, but remains in the
background. When you type `C-x b`, lem takes the cursor to the
minibuffer, where you can use the arrow keys to scroll and choose
the next buffer you want to edit. If you press `C-x C-b`, lem
provides a list of all buffers available, so you can choose one.
In this case, issue a `C-x o` command so that the cursor switches
to the buffer list window, from where you can choose the destination
buffer.

![](figs-prefix/minibuffer.jpg "Minibuffer"){width=250px}

(@minibuffer) Fibonacci Function

The figure above shows the editor. On the minibuffer you can
read the following message that was left there as the byproduct
of a `C-x C-s` save file command: 

> `Wrote /Users/ed/work/fib.nim`

Let us test the editor. Call `lem` from the `work` directory
that you created previously:

```bash
~$ cd work
~/work$ ls
bkp  hi.nim   ifib.nim xx
~/work$ lem fib.nim
```

Type the code shown in figure @minibuffer, then exit the
editor with the `C-x C-c` command. Next, compile and run
the program, as shown below.

```bash
~/work$ nim c -o:fib.x -d:release --nimcache:xx --hints:off fib.nim
~/work$ ./fib.x 5
13
```


### Meta keys {-#Meta}

To issue commands in the `M-κ` form, keep the `Alt` key
down and press the `κ` key.

+ `M-b` -- move back one word
+ `M-f` -- move forward one word
+ `M-g` -- go to the line given on the minibuffer
+ `M->` -- go to the end of buffer
+ `M-<` -- go to the beginning of buffer

It is pretty hard to press the `M-<` command. You must
keep the `Alt` key down, then press the `Shft` and `<`
keys together. However, there is a `~/.lem/init.el`
initialization file where one can define new commands.
So, let's add the following commands to the `~/.lem/init.el` file:

```Lisp
;; -*- lisp -*-
(in-package :lem)

(define-key *global-keymap* "Escape" 'keyboard-quit)

(define-key *global-keymap* "C-/" 'undo)

(define-key *global-keymap* "M-p" 'move-to-beginning-of-buffer)
(define-key *global-keymap* "M-n" 'move-to-end-of-buffer)
```
Now, next time you enter lem, if you press `M-p`, you
will go to the beginning of the buffer. Likewise, if
you press `M-n`, the cursor will be sent to the end
of the buffer.

### Search {-#Search}
If you press `C-s`, the computer enters into search
mode. First, lem prompts you for the text snippet S
that you want it to find in the current buffer. While
you are still typing, the cursor jumps to the first
occurrence of the text snippet S. To repeat the search,
all you need to do is press `C-s` again. Finally, you
must type `C-r` to reverse the direction of the search.


### Go to line {-#Go}
When you try to compile code containing errors, the compiler
usually reports the line number where the error occurred.
If you press `M-g`, lem prompts for a line number. As soon
as you type the number and press the `Enter` key, the cursor
jumps to the line where the error occurred.


### Transport and Copy {-#Transport}
To transport a region from one place to another, Nia
presses `C-Spc` to start the selection process and 
moves the cursor to select the region. Then she presses
`C-w` to kill her selection. Finally, she moves the
cursor to the insertion place, and presses the `C-y`
shortcut.

To copy a region, Nia presses `C-Spc` and moves the
cursor to select the region. Then she presses `M-w`
to save the selection into the kill ring. Finally,
she takes the cursor to the destination where the
copy is to be inserted and issues the `C-y` command.



# The Nim computer language

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
a request for the file name. In the snippet below, taken from
application @readfile, the `paramStr(0)` string contains the
application name.

```
  if paramCount() < 1:
    quit("Usage: " & paramStr(0) & " <filename.data>")
```

The local variable `s` receives the result of a sequence of
operations concerning the file contents.

The  `readFile(paramStr(1))` operation reads the file whose
name is on the command line. The `nums.data` file contains
space separated numbers that `.splitWhitespace` parses and
produces a sequence of strings.

Finally, `map(x => x.parseFloat)` transforms this sequence
into floating point numbers that `foldl(a+b)` adds together.
The `avg(xs: seq[float])` sums the floating point numbers
together into the `result` variable and calculates the length of
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
the embarassment of failure is manifest on the client's
terminal.



