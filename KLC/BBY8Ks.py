#########################
## Download Best Buy's ##
##    8K Statements    ##
## Date: June 18, 2019 ##
#########################

# libraries used
import requests 
import re 
import csv 
import math
import datetime as dt
import time


##############################
# Open 8K List and Save it
##############################

# create empty lists to store data
urlList = []

with open('8K_urls.txt', 'r') as f:
	for i in f:
		urlList.append(i)


##############################
# Downloading Pages
##############################

no_urls = len(urlList)
print("We have " + str(no_urls) + " Best Buy 8K statements to download today.")

# current time
t = dt.datetime.now()

for index, item in enumerate(urlList):
    page = requests.get(item)
    no_8K = index + 1  
    time.sleep(15)

    try:
    	path = '/home/<YOUR_NETID>/computing-orientation/KLC/BBY/8K_no' + str(no_8K) + '.html'
    	with open(path, "wb") as f:
    		f.write(page.content)
    	print("At " + time.strftime("%X") + ", we successfully saved 8K number " + str(no_8K) + ".")
    
    except Exception as e:
    	print(str(e))
    	pass




