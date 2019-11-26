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

