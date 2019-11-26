let src=system.paramStr(2)
let flags= ".x --nimcache:xx --hints:off -d:danger "
exec "nim c -o:" & src & flags & src & ".nim"




