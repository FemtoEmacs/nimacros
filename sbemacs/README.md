# Nim in SBEmacs

The tutorial's first three chapters are in `nimacros/chaps/nimdoc1.md`.
Their examples now use SBEmacs to edit, save, build and run Nim programs.

The mode is included in the updated SBEmacs source at
`lisp/modes/nim-mode.lisp`, and this repository carries the same file here.
Build and install the current SBEmacs (`make`, then `sudo make install`
in its source checkout). Restart the editor; `.nim`, `.nims` and `.nimble`
files activate Nim coloring, two-space indentation and menus automatically.
If needed, run **M-x load-mode**, type **nim**, and press Enter. TAB completes
mode names. **M-x nim-mode** reloads the mode.

To use this repository's copy with an SBEmacs that already supplies the
mode loader and Python mode helpers, create `~/.sbemacs/modes/` and copy
`sbemacs/nim-mode.lisp` there. User modes take precedence when load-mode runs.
Do not load this file in an older SBEmacs without that mode infrastructure.

- TAB indents and cycles levels; RET indents a new line.
- # / M-; comments or uncomments a region or line.
- MORE includes Build, Run, and next/previous definition.
- M-x nim-build saves and compiles the current `.nim` file.
- M-x nim-run saves, compiles and runs it; the minibuffer reads arguments.
- M-! opens the shell; C-c s or SEND executes the command; C-x 1 returns.

Nim must be on PATH. Build/Run uses the existing SBEmacs shell capture;
output appears below the source. It runs synchronously, with empty stdin.
Arguments are shell text: quote filenames containing spaces. Interactive
programs need piped input or redirection. This is not a terminal emulator;
ANSI color and cursor-control sequences are not interpreted.

The lexer follows the [Nim manual](https://nim-lang.org/docs/manual.html)
for nested comments, raw and triple strings, backtick identifiers and
numeric suffixes. It tolerates incomplete code while editing. Indentation
is an editing heuristic, not a complete Nim parser; TAB cycles alternative
levels for ambiguous constructs. Macros can introduce syntax beyond these
rules. The mode reuses SBEmacs's UTF-8 position helpers and existing Lisp/C
callbacks without changing the C core.

## Validation

Run `python3 sbemacs/test_examples.py` from this repository to compile
and execute Hello World, Zeller, and both Fibonacci implementations in a
temporary directory. The SBEmacs source checkout also supplies
`sbcl --script tests/run-nim-mode-tests.lisp` for the mode callbacks.
The first end-to-end editor test ran Zeller with `2016 8 31` on macOS
and displayed `3` in SBEmacs's output window.
