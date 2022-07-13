# Copies and renames files from iVMS, then runs ffmpeg and combines the files together and deletes working files.

import shutil, os

cctvdir = "C:/ivms_cctv/video/downloaded/footage/"
newpath = "D:/cctv/"
terms = ["Camera1_","Camera6_","Camera11_"]
count = 0

def add_line(filename, text):
    with open(filename, "a+") as file_object:
        file_object.seek(0)
        data = file_object.read(100)
        if len(data)>0:
            file_object.write("\n")
        file_object.write(text)

for term in terms:
    count = 0
    ff_file = newpath+term[:-1]+".txt"
    single_files = []
    for file in os.listdir(cctvdir):    
        if term in file:
            count += 1
            filename = file.partition(".")
            newfilename = "{0}_{1}.{2}".format(term[:-1],str(count),filename[2])
            single_files.append(newfilename)
            shutil.copy(cctvdir+file,newpath+newfilename)
            add_line(ff_file,"file '"+newfilename+"'")
    
    os.system("ffmpeg.exe -f concat -i {} -codec copy {}.mp4".format(ff_file,term[:-1]))
    print("Created file: ", term[:-1],".mp4")
    if count > 0:
        os.remove(ff_file)
        for file in single_files:
            os.remove(newpath+file)





