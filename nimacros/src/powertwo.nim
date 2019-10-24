
template optMul{`*`(a,2)}(a: int): int=
  let x = a
  x+x

template canonMul{`*`(a,b)}(a: int{lit}, b: int): int=
  b * a

var x: int
for i in 1 .. 1_000_000_000:
  x += 2 * i
echo x

