
import os
from docx2pdf import convert
from PyPDF2 import PdfMerger
import time

classname = "5A"
docx_path = "D:/Reports/DOCX/"
pdf_path = "D:/Reports/PDF/"+classname+"/"
classes = ["RA","RB","1A","1B","2A","2B","3A","3B","4A","4B","5A","5B","6A","6B"]
logfile = "D:/Reports/log.txt"
merger = PdfMerger()
count = 0

def add_line(filename, text):
    with open(filename, "a+") as file_object:
        file_object.seek(0)
        data = file_object.read(100)
        if len(data)>0:
            file_object.write("\n")
        file_object.write(text)


for root, dirs, files in os.walk(docx_path+classname):

    for name in files:
        if "completed" in name:
            if name[0] != "~":
                count += 1
                fullfilename = os.path.join(root, name)
                newfilename = os.path.join(pdf_path, os.path.splitext(name)[0]+".pdf")
                convert(fullfilename, newfilename)
                add_line(logfile,fullfilename)
                merger.append(newfilename)
                print("Converted: ", newfilename)
                time.sleep(2)

merger.write("D:/Reports/PDF/"+classname+".pdf")
add_line(logfile,classname+": "+str(count))
print("Count: ", count)

merger.close()



