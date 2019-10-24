#when defined(linux) and defined(amd64): # TODO: standalone kills this
when defined(amd64):
  import linux_x86_64/call
  import linux_x86_64/nr
  export call.syscall, nr.Number
elif defined(i386):
  import linux_x86/call
  import linux_x86/nr
  export call.syscall, nr.Number
else:
  {.error: "No syscalls defined for your platform".}

when isMainModule:
  discard syscall(WRITE, 1, cstring("Hello!\n"), 7)
