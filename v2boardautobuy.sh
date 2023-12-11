#!/bin/bash
int=0
domain=
email=
passwd=
planid=
coupon=

authcode=$(curl -s "https://$domain/api/v1/passport/auth/login" --data-raw "email=$email&password=$passwd" --compressed| python3 -c "import sys, json; restr=json.load(sys.stdin); print(restr['data']['auth_data'])") 

echo $authcode

while(( $int<60 ))
do
    let "int++"
    orderno=$(curl -s "https://$domain/api/v1/user/order/save" -H "authorization:${authcode}" --data-raw "period=month_price&plan_id=$planid&coupon_code=$coupon" --compressed | python3 -c "import sys, json; print(json.load(sys.stdin)['data'])")
    echo $orderno
    curl -s "https://$domain/api/v1/user/order/checkout" -H "authorization:${authcode}" --data-raw "trade_no=${orderno}&method=1" --compressed > /dev/null
done

