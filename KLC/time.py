#######################################
# Printing the time every 20 seconds ##
#######################################

# libraries used
import time

# first statement
print("This file tells you the time after every 20 seconds.")


# print the time after every 20 seconds
for i in range(10000):
    print("The time is now: " + time.strftime("%X") + ". Time flies when you are on KLC.")
    time.sleep(20)





