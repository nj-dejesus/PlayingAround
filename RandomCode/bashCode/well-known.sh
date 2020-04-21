#!/bin/bash 

clear 

rm opened 

touch opened 

echo "This Will Search a Specific IP Address and the port Ranges you want to Check" 

echo "Enter the network address (ie. 192.168.0.xx)" 

read net 

echo "Enter the last Octet Start" 

read startOct 

echo "Enter the last Octet End" 

read endOct 

portArrayTCP=(20 21 22 23 25 53 80 110 135 139 443 445 3389) 

echo "We will scan for well-known ports 20, 21, 22, 23, 25, 53, 80, 110, 135, 139, 443, 445 and 3389" 

for ((i=$startOct; $i<=$endOct; i++)) 

do 

    echo -e "\e[3$(( $RANDOM *6 /32767 +1))mScanning ports for the ip $net.$i" 

    for x in ${portArrayTCP[@]} 

    do 

    #    echo "This is TCP" 

    nc -nzvw1 $net.$i $x 2>&1 | grep open | awk -F' ' '{print $2 ,$3}' >> opened 

    done 

done 

echo "Scan complete for Well-known ports for $net.$startOct - $net.$endOct"
