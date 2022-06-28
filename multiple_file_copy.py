# Quick script to copy multiple files from one folder to another depending on terms found int he filename

import os, shutil

path = "Downloads/"
term = "_Jun2022"
pathToCopyTo = "D:/Saved/2022/June/"
count = 0

for file in os.listdir(path):
  if term in file:
    count += 1
    shutil.copy(path+file, pathToCopyTo)

Print("Number of files copied: ", count)
