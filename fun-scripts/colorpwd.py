from __future__ import print_function
import sys

pwd=sys.argv[1]
colors=[160,196,202,208,214,220,226]
if pwd[0] == "/":
  pwd=pwd[1:]

delimited=pwd.split("/")
background_code=8

count = 0
for i in delimited:
  index = count + len(colors) - len(delimited)
  if index < 0:
    index = 0
  print("\033[1;48;5;" +str(background_code) +";38;5;"+str(colors[index])+"m/"+i,end='')
  count += 1

