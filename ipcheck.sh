#!/bin/bash

if [[ -e ".public-ip" ]]; then #Test if .public-ip file exists
    ip_add=`cat .public-ip`
else
    touch ".public-ip"
fi

ip_add_challenge=`curl -s http://icanhazip.com`

if [ "$ip_add" == "$ip_add_challenge" ]; then
    echo 'IP has not changed'
    exit
else
    echo 'IP change is detected'
    echo "IP change is detected. Old IP was $ip_add. New IP is $ip_add_challenge." | mail -s 'IP Change Detected' -r 'information@mail.com' emailaddress@mail.com
    echo $ip_add_challenge > .public-ip
fi
