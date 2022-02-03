import re
def getPrice(price):
     res=re.findall(r'A\$(\d+)',price)
     s = [str(integer) for integer in res]
     a_string = "".join(s)
     res1 = int(a_string)
     return res1
print(getPrice("A$39.99"))
