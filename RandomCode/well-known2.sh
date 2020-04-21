#!/bin/bash

clear

rm opened

touch opened

echo "This Will Search a Specific IP Address and the port Ranges you want to Check"

echo "Enter the first 3 octets of the network address (ie. 192.168.0)"

read net

echo "Enter the last Octet Start"

read startOct

echo "Enter the last Octet End"

read endOct

bool=1

printf "Please enter ports to scan. Enter -1 to add ports 20, 21, 22, 23, 25, 53, 80, 110, 137, 138, 139, 143, 445, and 443 to scan list\nEnter -2 to start scanning\n"

while bool=1
do
    read choice
    if [ "$choice" -eq -1 ]
    then
        portArrayTCP=(20 21 22 23 25 53 80 110 137 138 139 143 445 443)
        printf "List now consists of ports 20, 21, 22, 23, 25, 53, 80, 110, 137, 138, 139, 143, 445, and 443\n"
    elif [ "$choice" -eq -2 ]
    then
        bool=0
        break
    else
        portArrayTCP+=($choice)
        printf "Added $choice to scan list\n"
    fi
done

echo "Scanning selected ports, please wait..."

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
