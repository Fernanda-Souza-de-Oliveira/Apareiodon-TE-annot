#!/usr/bin/env python3

#Takes repeatmasker wo input and quantifies lengths
import sys
import csv
#Import and parse the file
input = sys.argv[1]
count = len(open(input).readlines(  ))
lol = list(csv.reader(open(input, 'rt'), delimiter='\t'))

#Import and parse the file, TEs and Lens
input2 = sys.argv[2]
count2 = len(open(input2).readlines(  ))
lol2 = list(csv.reader(open(input2, 'rt'), delimiter='\t'))

for i in range(0,count):
        TE=lol[i][8]
        temp=TE.split(":")[1]
        temp2=temp.split("\"")[0]
        #print(TE,temp2)
        TE=temp2
#ID=564571;Target "Motif:SINE-8_AP" 6 58
        for j in range(0,count2):
                chars=len(lol2[j][0])
                TE2=TE[len(TE)-chars:len(TE)]
                #TE2=TE
                #print(TE,TE2,lol2[j][0])
                if(TE2==lol2[j][0]):
			###Check length
                        if(int(lol[i][4])-int(lol[i][3])>int(lol2[j][1])):
				##Bigger than cut off
                                for x in range(0,len(lol[i])):
                                        if(x==len(lol[i])-1):
                                                print(lol[i][x])
                                        else:
                                                print(lol[i][x],end="\t")



