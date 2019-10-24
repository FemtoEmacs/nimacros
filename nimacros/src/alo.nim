import syscall

const STDOUT = 1

proc write(fd: cint, buf: cstring, len: csize): clong
          {.inline, discardable.} =
  syscall(WRITE, fd, buf, len)

proc exit(n: clong): clong {.inline, discardable.} =
  syscall(EXIT, n)

proc main {.exportc: "_start".} =
  write STDOUT, "Hello!\n", 7
  exit 0
