#!/usr/bin/env python3
import socket
import subprocess
import sys
import netaddr
import ipaddress
from datetime import datetime
from netaddr import IPNetwork

#clear the screen
subprocess.call('clear', shell=True)

#Ask for input
ipNetwork = input ("Enter Ip/Subnet to scan: ")

#Well-known Ports 20, 21, 22, 23, 25, 53, 80, 110, 135, 139, 445 and 3389
wellknown = [20, 21, 22, 23, 25, 53, 80, 110, 135, 139, 445, 3389]

#Print a banner
print ("*" *60)
print ("Please wait, scanning remote host", ipNetwork)
print ("Well-known ports: ", end = ' ')
for i in range(len(wellknown)):
	print(wellknown[i], end = ' ')
print ("")
print ("*" *60)

#Check what time the scan started
t1 = datetime.now()

#make an array of ips from input 
remoteServerIPs = ([str(ip) for ip in ipaddress.IPv4Network(ipNetwork)])

#Using the range function to specify ports (here it will scan all ports between 1 and 1024)
#Error Handling Added

try:
	for ip in range(len(remoteServerIPs)):
		remoteServerIP = str (ip)
		print ("Scanning ", remoteServerIPs[ip])
		for port in wellknown:
			#This scans for UDP Ports
			sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
			result = sock.connect_ex((remoteServerIP, port))
			if result == 0:
				print ("Port {}:\tOpen".format(port))
			sock.close()
except KeyboardInterrupt:
	print ("You pressed Ctrl+C")
	sys.exit()

except socket.gaierror:
	print ("Hostname could not be resolved. Exiting")
	sys.exit()

except socket.error:
	print ("Couldn't connectt to server")
	sys.exit()

#Second Time check
t2 = datetime.now()

#Calculate the difference of time, to see how long the script ran
total = t2 - t1

#Print the total time ran
print ("Scanning Completed in: ", total)
