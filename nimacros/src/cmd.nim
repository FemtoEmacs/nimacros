import commandeer

commandline:
  option texto, string, "string", "s", "Fibonacci"
  argument inteiro, int

echo ("O inteiro= ",  inteiro)
echo ("A string= ", texto)

proc fib(n: int) : int=
  if n < 2: 1
  else: fib(n-1)+fib(n-2)

echo texto, " ", inteiro, "=", fib(inteiro)

