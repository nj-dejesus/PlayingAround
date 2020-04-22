#!/usr/bin/env python3
import socket
import subprocess
import sys
from datetime import datetime

#clear the screen
subprocess.call('clear', shell=True)

#Ask for input
remoteServer = raw_input("Enter a remote host to scan: ")
remoteServerIP = socket.gethostbyname(remoteServer)

#Print a banner
print "-" *60
print "Please wait, scanning remote host", remoteServerIP
print "*" *60

#Check what time the scan started
t1 = datetime.now()

#Using the range function to specify ports (here it will scan all ports between 1 and 1024)
#Error Handling Added

try:
	for port in range(1,1025):
		sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
		result = sock.connect_ex((remoteServerIP, port))
		if result == 0:
			print "Port {}:\tOpen".format(port)
		sock.close()
except KeyboardInterrupt:
	print "You pressed Ctrl+C"
	sys.exit()

except socket.gaierror:
	print "Hostname could not be resolved. Exiting"
	sys.exit()

except socket.error:
	print "Couldn't connectt to server"
	sys.exit()

#Second Time check
t2 = datetime.now()

#Calculate the difference of time, to see how long the script ran
total = t2 - t1

#Print the total time ran
print "Scanning Completed in: ", total
