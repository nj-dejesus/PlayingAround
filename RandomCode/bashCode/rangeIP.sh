#!/bin/bash

clear

echo "This Will Search a Specific IP Address and the port Ranges you want to Check"


echo "Enter the network address (ie. 192.168.0.x)"
read net

echo "Enter the last Octet Start"
read startOct

echo "Enter the last Octet End"
read endOct

echo "Start Range of Ports: "
read startPort

echo "End Range of Ports: "
read endPort

clear

echo -e "For the network $net.$startOct to $net.endOct"
echo -e "\tu for UDP scan"
echo -e "\tt for TCP scan"
echo -e "\tb for Both UDP and TCP"
echo -e "\te for exit"
read whatYouWant


if [ $whatYouWant == "u" ] || [ $whatYouWant == "U" ]  
then
    for (( i=$startOct; $i<=$endOct; i++))
    do
        echo -e "\e[3$(( $RANDOM *6 /32767 + 1))mScanning $net.$i" 
        #OPEN UDP Ports for $net
            for (( x=$startPort; $x<=$endPort; x++))
            do
                nc -nuzvw1 $net.$i $x 2>&1 | grep open | awk -F' ' '{print $2 ,$3}' >> /root/Tools/OpenedPorts/${net}-UDP
                #echo -e "\e[3$(( $RANDOM *6 /32767 + 1))mThis shit sucks $x"
            done
        #echo -e "\e[3$(( $RANDOM *6 /32767 + 1))m $net.$i done"
    done
    echo "You finished the scan of $net with ports $startPort - $endPort"
elif [ $whatYouWant == "t" ] || [ $whatYouWant == "T" ]
then
    for (( i=$startOct; $i<=$endOct; i++))
    do
        echo -e "\e[3$(( $RANDOM *6 /32767 + 1))mScanning $net.$i"
        #OPEN TCP Ports for $net
        for (( x=$startPort; $x<=$endPort; x++))
        do
            nc -nzvw1 $net.$i $x 2>&1 | grep open | awk -F' ' '{print $2 ,$3}' >> /root/Tools/OpenedPorts/${net}-TCP
            #echo -e "\t\t\e[3$(( $RANDOM *6 /32767 + 1))mPort $x"
        done
        echo -e "\e[3$(( $RANDOM *6 /32767 + 1))m $net.$i done"
    done
    echo "You finished the scan of $net with ports $startPort - $endPort"
elif [ $whatYouWant == "b" ] || [ $whatYouWant == "B" ]
then
    for (( i=$startOct; $i<=$endOct; $i++))
    do
        echo -e "\e[3$(( $RANDOM *6 /32767 + 1))mScanning $net.$i"
        #    echo "This is TCP"
        #OPEN TCP Ports for $net
        for (( x=$startPort; $x<=endPort; $x++))
        do
            nc -nzvw1 $net.$i $x 2>&1 | grep open | awk -F' ' '{print $2 ,$3}' >>  /root/Tools/OpenedPorts/${net}-TCP
            #echo "This is UDP"
            #OPEN UDP Ports for $net
            nc -nuzvw1 $net.$i $x 2>&1 | grep open | awk -F' ' '{print $2 ,$3}' >>  /root/Tools/OpenedPorts/${net}-UDP
            #echo -e "\e[3$(( $RANDOM *6 /32767 + 1))mThis shit sucks $x"
        done

    done
    echo "You finished the scan of $net with ports $startPort - $endPort"
else
    echo "Goodbye!"
    exit 0

fi
