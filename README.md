# nimacros
Documentation for Nim Macros

This work assumes that the reader already knows how to program and is familiar with command line tools. Therefore, as far as programming goes, the only subject that the author discusses is macro designing. Below, you will learn how to build the documentation for Nim macros, by using pandoc. For the convenience of those who don't want to install pandoc, here is a link to the Portable Document Format (PDF) version of the file:

[Documentation for Nim macros](https://github.com/FemtoEmacs/nimacros/blob/master/nimdoc.pdf)

If you have a snippet that can help with the understanding a concept that was not well explained in this tutorial, please send us your snippet. This is a collective work that depends on your collaboration.

## Installation

The Nim programming language is very easy to install. Follow the instructions on the link below, and you cannot go wrong or even astray.

[Documentation for Nim macros](https://nim-lang.org/install.html)

## Tutorial

The goal of this project is to prepare documentation on Nim macros. You will find two things in this repository. The first one is a Portable Document Format (PDF) file, where you can learn how to write macros in Nim. It is work in progress, therefore you will find many spelling mistakes, grammar errors and, what is worse, incomplete explanations. I hope that these shortcomings will disappear with time and hard work from my collaborators. The other things you will find here are short examples, that you can compile with the help of a Makefile. Let us suppose that you want to compile the `rdwrt.nim` source code file, that implements an emulator for an HP calculator. From the `src` folder, type the following command:

```Shell
~/nim/nimacros/src master ×
› make APP=rdwrt
nim c -o:rdwrt.x -d:danger --hints:off --nimcache:lixo rdwrt.nim
CC: stdlib_formatfloat.nim
CC: stdlib_io.nim
CC: stdlib_system.nim
CC: stdlib_parseutils.nim
CC: stdlib_strutils.nim
CC: stdlib_posix.nim
CC: stdlib_times.nim
CC: stdlib_os.nim
CC: rdwrt.nim

~/nim/nimacros/src master ×
› ./rdwrt.x
> 3 4 x 5 6 x +
42.0
```

You can also modify the `nimdoc.md`, which is written in the `Markdown` format. There is an application called *pandoc* that compiles `Markdown` to PDF. The compilation from the `Markdown` format to PDF is also achieved through a Makefile script, as shown below:

```Shell
~/nim/nimacros master ×
› make D=nimdoc
pandoc -V geometry:margin=1in -V documentclass=report\
        chaps/*.md  nimdoc.md --syntax-definition\
        nimrod.xml -o nimdoc.pdf
```

## Nim Language
The Nim programming language has a syntax that is similar to the one you will find in the Python programming langauge. This syntax is recognised as easy to learn, friendly, and therefore efficent to wrote code in. The main difference between Nim and Python is that Nim generates fast code with small runtime and heap consumption. The Python programming language is instead interpreted, so generally requires the Python runtime to be installed on a computer too, before the programer's code can be run. Nim code however compiles into a single binary file, and does not require any addtional Nim runtime to be installed on a computer, before that binary is exectuted. The complied Nim program usually runs many times faster that the equivilent Python program as well, which is always a nice benefit to have.

Macro is a tool that you can use for tailoring the language for the application. If the language is enriched with macros it can help model a problem well, so the developer will potentially find a solution without errors in less time.

