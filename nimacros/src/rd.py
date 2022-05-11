import sys

def avg(xs: list[float]) -> float:
    result= 0.0
    n= 0.0
    for x in xs:
        result= result + x
        n= n+1.0
    return result/n

numbers = []

def rdfile(file_name:str) -> list[float]:
  numbers= []
  with open(file_name) as fp:
     #Iterate through each line
     for line in fp:
        numbers.extend(
            [float(item)
             for item in line.split()
             ])
  return numbers

def main():
  print('Average= ', avg(rdfile(sys.argv[1])))

main()



