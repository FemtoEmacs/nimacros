proc webcode(s: string): string =
  case s
  of "C3%A1" : "á"
  of "C3%A9" : "é"
  of "C3%AD" : "í"
  of "C3%B3" : "ó"
  of "C3%BA" : "ú"
  of "C3%A3" : "ã"
  of "C3%B1" : "ñ"
  of "C3%AA" : "ê"
  of "C3%B4" : "ô"
  of "C3%B5" : "õ"
  of "C3%A2" : "â"
  of "C3%AE" : "î"
  of "C3%BB" : "û"
  of "C3%A8" : "è"
  of "C3%A0" : "à"
  of "C3%A7" : "ç"
  of "D0%90" : "А"
  of "D0%B4" : "д"
  of "D0%B8" : "и"
  of "D0%BB" : "л"
  of "D1%8F" : "я"
  of "D1%81" : "с"
  of "D0%BA" : "к"
  of "D0%B0" : "а"
  of "D0%9A" : "К"
  of "D0%BE" : "о"
  of "D1%82" : "т"
  of "D0%B2" : "в"
  of "D0%A0" : "Р"
  of "D0%B3" : "г"
  of "D0%BD" : "н"
  of "C3%84" : "Ä"
  of "C3%A4" : "ä"
  of "C3%96" : "Ö"
  of "C3%B6" : "ö"
  of "C3%9C" : "Ü"
  of "C3%BC" : "ü"
  of "C3%9F" : "ß"
  of "C3%85" : "Å"
  of "C3%A5" : "å"
  else: s

proc code*(s: string) : string =
  result= ""
  var i= 0
  while i < s.len:
    if s[i] == '%' and i+6 <= s.len:
       result = result & webcode(s[i+1..i+5])
       i= i+6
    else: 
      result.add(s[i])
      i= i+1

## echo code("ab%C3%B3%C3%A7")

