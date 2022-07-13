# Copies and renames files from iVMS, ready for FFMPEG to combine the videos into one

# Use -> ffmpeg.exe -f concat -i file.txt -codec copy output.mp4 

import shutil, os

cctvdir = "C:/ivms_cctv/video/downloaded/footage/"
newpath = "D:/cctv/"
terms = ["Camera1_","Camera6_","Camera11_"]
count = 0

def add_line(filename, text):
    with open(filename, "a+") as file_object:
        file_object.seek(0)
        data = file_object.read(100)
        if len(data)>0: # Add new line if file contains data
            file_object.write("\n")
        file_object.write(text)

for term in terms:
    count = 0
    ff_file = newpath+term[:-1]+".txt"
    for file in os.listdir(cctvdir):    
        if term in file:
            count += 1
            filename = file.partition(".")
            newfilename = term+"_"+str(count)+"."+filename[2]
            shutil.copy(cctvdir+file,newpath+newfilename)
            add_line(ff_file,"file '"+newfilename+"'")
            print("Renamed ",newfilename)
        


