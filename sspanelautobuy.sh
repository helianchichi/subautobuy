#!/bin/bash
int=0
domain=
email=
passwd=

rm /tmp/checkin.cook
loginstr=$(curl -k -s -L -e  '; auto' -d "email=$email&passwd=$passwd&code=" -c /tmp/checkin.cook "https://$domain/auth/login")
echo -en $loginstr
echo -e "\n"

while(( $int<=60 ))
do
    let "int++"
    retstr=$(curl -k -s -d "" -b /tmp/checkin.cook "https://$domain/user/buy" --data-raw 'coupon=&shop=1&autorenew=1&disableothers=1')
    echo -en $retstr
    echo -e "\n"
done
