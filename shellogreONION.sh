#!/bin/bash
# This SOFTWARE PRODUCT is provided by THE PROVIDER "as is" and "with all faults." THE PROVIDER makes no representations or warranties of any kind 
# concerning the safety, suitability, lack of viruses, inaccuracies, typographical errors, or other harmful components of this SOFTWARE PRODUCT. 
# There are inherent dangers in the use of any software, and you are solely responsible for determining whether this SOFTWARE PRODUCT is compatible 
# with your equipment and other software installed on your equipment. You are also solely responsible for the protection of your equipment and backup 
# of your data, and THE PROVIDER will not be liable for any damages you may suffer in connection with using, modifying, or distributing this SOFTWARE PRODUCT.
################      IMPORTANT!!!  READ THIS!!!        ######################
# To run this you will need an account, API KEY and SECRET at TradeOgre.     #
# You will need to create a file in the same directory as this file named    #
# shellogreks.txt   You need to put your API KEY/SECRET in the file on one   #
# line with a colon ":" between them.                                        # 
# Do not hit enter at the end of the line.                                   # 
# Example:                                                                   #
# ac67d2345:1d742a34c9  (they will be much longer)                           #
#                                                                            #
# You will need to have curl and jq available. Please let me know if your    #
# system asks for anything else.                                             #
#                                                                            #
# CREDIT: I forked this from https://github.com/ShellCrypto/ShellOgre        #
# I made changes to it to work with DeepOnion and added a couple features.   #
# It is still kind of rough and I will clean up some things as I get time.   #
# It works for me but I make no promise that it will not take all your DOGE. #
# I can not be responsible if it wipes out your pr0n collection.             #
# I ADVISE TO READ THE CODE FOR YOUR SAFETY AND PEACE OF MIND.               #
# This script is licensed under the GNU General Public License v3.0          #
#                                                                            #
##############################################################################
# TODO:
# Too much to waste time writing up a TODO list right now :P
#
# Complete converting script to dynamic.
# Complete [default] inputs. 
# Learn at least enough jq to pretty up the output.
#
##############################################################################
# My TradeOgre ONION deposit - 
# My TradeOgre BTC   deposit - 

## Set key and secret.

# KEY=
# SECRET=
#
   ksvalue=`cat shellogreks.txt`
#    echo $ksvalue
#######################
#                  ######## ENDPOINTS #########
ENDPOINT=https://tradeogre.com/api/v1
# endpoints Public API    ( All are Method (GET) )
MARKETS=/markets           # Retrieve a listing of all markets and basic information including current price, volume, high, low, bid and ask.
# /orders/{market}   # Retrieve the current order book for {market} such as BTC-ONION.
# /ticker/{market}   # Retrieve the ticker for {market}, volume, high, and low are in the last 24 hours, initialprice is the price from 24 hours ago.
# /history/{market}  # Retrieve the history of the last trades on {market} limited to 100 of the most recent trades. The date is a Unix UTC timestamp.
#######################
# endpoints Private API    ( Buy, Sell, Cancel, Orders, Balance are POST )
BUY=/order/buy             # Fields= market quantity price . 
SELL=/order/sell            # Fields= market quantity price .
CANCEL=/order/cancel          # Fields= uuid all . Cancel an order on the order book by uuid. The uuid parameter can also be set to all.
MYORDERS=/account/orders        # Fields= market . Retrieve the active orders under your account. The market field is optional, and leaving it out will return all orders in every market. Date is a Unix UTC timestamp.
# /account/order/{uuid}  # Retrieve information about a specific order by the uuid of the order.
# /account/balance       # Fields= currency . Get the balance of a specific currency for you account. The currency field is required, such as ONION.
# /account/balances      # Retrieve all balances for your account.
#######################
#                 ######## VARIABLES ########  
# coin_choice=        # The coin you want to buy, sell, etc.
# ksvalue=            # The $KEY:$SECRET pair for authorization for Private API use.
# market=             # BTC-ONION     BTC-(coin)
# quantity=           # 13.0           BTC must be > 0.00005000
# minquantity         # 
# price=              # 0.00000381    must be > 0.00000001
# ONIONUSD=           # USD price of ONION
# BTCONION=           # BTC price of ONION
# BTCBTC=             # Current USD price of BTC 
# CURRENTBTC=         # Your current balance of BTC  
# CURRENTONION=       # Your current balance of ONION 
MKT1=BTC-ONION
# 
# 
# log_file=tx_history.txt
###########################################################################################################################################################
# -e '\E[32;40m'"\033[1m"    # Green on Black
# -e '\E[31;40m'"\033[1m"    # Red on Black
# -e '\E[34;40m'"\033[1m"    # Blue on Black
# -e '\E[33;40m'"\033[1m"    # Yellow on Black
# -e '\E[36;40m'"\033[1m"    # Cyan on Black
# -e '\E[35;40m'"\033[1m"    # Magenta on Black
# -e '\E[37;40m'"\033[1m"    # White on Black
# -e '\E[33;47m'"\033[1m"    # Black on White
# 
#
#######################################################################

## Print selection menu.

printf "\n"

clear

showMenu(){
echo -e '\E[32;40m'"\033[1m"
unset market ; unset quantity ; unset price 
  echo "===================================="
  echo "    ShellOgreONION    "
  echo "===================================="
  echo "[0] EXIT."
  echo "[1] Get BTC Balance."
  echo "[2] Get ONION Balance."
  echo "[3] BUY ONION with BTC"
  echo "[4] SELL ONION for BTC"
  echo "[5] CANCEL order by uuid"
  echo "[6] Display Order Book" 
  echo "[7] My Market Orders"
  echo "[8] Market Ticker"
  echo "[9] Market History"
  echo "[10] Test area"
  echo "===================================="

  printf "\n"
  printf "\n"

  read -p "Please Select A Number: " mc
  return $mc
}

## Execute the selection input.

while [[ "$m" != "0" ]]
do
##
  if [[ "$m" == "1" ]]; then

    ## Get BTC Balance.

    printf "\n"
    printf "\n"

    echo Your BTC balance is:

    curl -s --request POST \
    --url https://tradeogre.com/api/v1/account/balance \
    --user $ksvalue \
    --form currency=BTC | jq '.balance' | tr '"' ' '

    printf "\n"
    printf "\n"

    echo Your available BTC balance is:

    curl -s --request POST \
    --url https://tradeogre.com/api/v1/account/balance \
    --user $ksvalue \
    --form currency=BTC | jq '.available' | tr '"' ' '

    printf "\n"
    printf "\n"

    
    elif [[ "$m" == "2" ]]; then

    ## Get ONION Balance.

    printf "\n"
    printf "\n"

    echo Your ONION balance is:

    curl -s --request POST \
    --url https://tradeogre.com/api/v1/account/balance \
    --user $ksvalue \
    --form currency=ONION | jq '.balance' | tr '"' ' '

    printf "\n"
    printf "\n"

    echo Your available ONION balance is:

    curl -s --request POST \
    --url https://tradeogre.com/api/v1/account/balance \
    --user $ksvalue \
    --form currency=ONION | jq '.available' | tr '"' ' '

    printf "\n"
    printf "\n"

    elif [[ "$m" == "3" ]]; then

    ## Buy ONION with BTC

    BTCONION=$(curl -s --request GET \
    --url https://tradeogre.com/api/v1/ticker/BTC-ONION | jq '.price' | tr -d '"')
  
    CURRENTBTC=$(curl -s --request POST \
    --url https://tradeogre.com/api/v1/account/balance \
    --user $ksvalue \
    --form currency=BTC | jq '.available' | tr -d '"')
    BTCBTC=$(curl -s https://api-pub.bitfinex.com/v2/ticker/tBTCUSD | awk -F',' '{print  $7}')
    ONIONUSD=$(echo $BTCBTC*$BTCONION | bc)
    echo "[ If you are going to bid less than the ONION Price you will need to buy more than the minimum quantity. ]"
    echo "[ If you get an error 'Quantity must be at least 0.00005' then increase quantity or bid higher price.    ]"
    echo
    echo Current ONION Price is 1 ONION = "$BTCONION" BTC, worth $ONIONUSD USD. &&
    #echo How many BTC would you like to trade for ONION? &&
    echo Your current BTC balance is $CURRENTBTC BTC. 1 BTC = $BTCBTC
    buybtconion="BTC-ONION"
    printf "\n"
    
  while true; do
  
    read -p "Which market would you like [BTC-ONION]:" market ; market=${market:-BTC-ONION}
    minquantity=$(echo 0.00005000/$BTCONION | bc)
    echo "Minimum quantity of ONION is : " $minquantity
    read -p "Enter quantity desired [$minquantity]: " quantity ; quantity=${quantity:-$minquantity} 
    read -p "Enter price bid per ONION (default= current BUY price) [$BTCONION] : " price ; price=${price:-$BTCONION}
    echo
    echo
    echo "This is a BUY order."
    echo "You entered (read carefully):"
    echo "market= " $market
    echo "quantity= " $quantity
    echo "price= " $price
    echo
    read -p "Are the above values what you wanted ?" yn
    case $yn in
        [Yy]* ) break;;
        [Nn]* ) continue;;
        * ) echo "Please answer yes or no.";;
    esac
  done
    while true; do
   read -p "Would you like to execute this transaction?" yn
    case $yn in
        [Yy]* ) break;;
        [Nn]* ) exec $0;;
        * ) echo "Please answer yes or no.";;
    esac
   done  
  curl -s --request POST \
    --url $ENDPOINT$BUY \
    --user $ksvalue \
    --form market=$market \
    --form quantity=$quantity \
    --form price=$price         #  | tee -a $log_file
   
    printf "\n"
    printf "\n"

    elif [[ "$m" == "4" ]]; then

    ## Buy BTC with ONION

    ONIONBTC=$(curl -s --request GET \
    --url https://tradeogre.com/api/v1/ticker/BTC-ONION | jq '.bid' | tr -d '"') 

    BTCUSD=$(curl -s -X GET "https://api.coingecko.com/api/v3/simple/price?ids=bitcoin&vs_currencies=usd" -H  "accept: application/json" | jq '.bitcoin.usd')

    CURRENTONION=$(curl -s --request POST \
      --url https://tradeogre.com/api/v1/account/balance \
      --user $ksvalue \
    --form currency=ONION | jq '.available' | tr -d '"')
    printf "\n"

    
     BTCONION=$(curl -s --request GET \
      --url https://tradeogre.com/api/v1/ticker/BTC-ONION | jq '.price' | tr -d '"')
     CURRENTBTC=$(curl -s --request POST \
      --url https://tradeogre.com/api/v1/account/balance \
      --user $ksvalue \
      --form currency=BTC | jq '.available' | tr -d '"')
    
    BTCBTC=$(curl -s https://api-pub.bitfinex.com/v2/ticker/tBTCUSD | awk -F',' '{print  $7}')
    ONIONUSD=$(echo $BTCBTC*$BTCONION | bc)
    echo "[ If you are going to bid less than the ONION Price you will need to buy more than the minimum quantity. ]"
    echo "[ If you get an error 'Quantity must be at least 0.00005' then increase quantity or bid higher price.    ]"
    echo
    echo Current ONION Price is 1 ONION = "$BTCONION" BTC, worth $ONIONUSD USD. &&
    echo Your current BTC balance is $CURRENTBTC BTC. 1 BTC = $BTCBTC
    
    printf "\n"
    
    while true; do
   
    read -p "Which market would you like [BTC-ONION]:" market ; market=${market:-BTC-ONION}
    minquantity=$(echo 0.00005000/$BTCONION | bc)
    echo "Minimum quantity of ONION is: " $minquantity
    read -p "Enter quantity desired [$minquantity]:" quantity ; quantity=${quantity:-$minquantity} 
    read -p "Enter price of each ONION [$BTCONION]: " price ; price=${price:-$BTCONION}
    echo
    echo "This is a SELL order."
    echo "You entered (read carefully):"
    echo "market= " $market
    echo "quantity= " $quantity
    echo "price= " $price
    echo
    read -p "Are the above values what you wanted ?" yn
     case $yn in
        [Yy]* ) break;;
        [Nn]* ) continue;;
        * ) echo "Please answer yes or no.";;
     esac
    done
  
    while true; do
    read -p "Would you like to execute this transaction?" yn
     case $yn in
        [Yy]* ) break;;
        [Nn]* ) exec $0;;
        * ) echo "Please answer yes or no.";;
     esac
    done  
  curl --request POST \
    --url $ENDPOINT$SELL \
    --user $ksvalue \
    --form market=$market \
    --form quantity=$quantity \
    --form price=$price          #  | tee -a $log_file

    printf "\n"
    printf "\n"
    
    elif [[ "$m" == "5" ]]; then
    
    ## Cancel Order
    
    read -p "Enter the uuid # " uuid
    
    curl -s --request POST \
    --user $ksvalue \
    --url $ENDPOINT$CANCEL  \
    --form uuid=$uuid 
        
    printf "\n"
    printf "\n"
    
        
    elif [[ "$m" == "6" ]]; then
      
    ## Market Orders
    
    read -p "Enter Market [BTC-ONION]:" market ; market=${market:-BTC-ONION}
    (curl -s --request GET \
    --url $ENDPOINT"/orders/"$market | jq . | tr -d '{,"}' | sed 's/success: true//g')  
    
    printf "\n"
    printf "\n"
    
    elif [[ "$m" == "7" ]]; then
    
    ## Get My Market Orders
    
    read -p "Enter Market [BTC-ONION]:" market ; market=${market:-BTC-ONION}
    (curl -s --request POST \
    --url $ENDPOINT$MYORDERS \
    --user $ksvalue \
    --form market=$market | jq . | tr -d '"[],{}')  
       
    elif [[ "$m" == "8" ]]; then
      
    ## Market Ticker
    
    read -p "Enter Market [BTC-ONION]:" market ; market=${market:-BTC-ONION}
    echo -e '\E[33;40m'"\033[1m"
    curl -s --request GET \
    --url $ENDPOINT"/ticker/"$market 
    
    printf "\n"
    printf "\n"
        
     elif [[ "$m" == "9" ]]; then
     ## GET Market History
    
    read -p "Enter Market [BTC-ONION]:" market ; market=${market:-BTC-ONION}
    echo -e '\E[34;40m'"\033[1m"
    echo "           DATE           TYPE              PRICE                  QUANTITY"
    echo -e '\E[32;40m'"\033[1m""           ----           ----              -----                  --------"
  (curl -s --request GET \
   --url $ENDPOINT"/history/"$market | jq -cn --stream "fromstream(1|truncate_stream(inputs))")
      
    
    printf "\n"
    printf "\n"
    
    
    elif [[ "$m" == "10" ]]; then
      #Testing
      
      
      
      
      
      
      
    printf "\n"
    printf "\n"  
      
  fi
  showMenu
  m=$?
done

############################################################################################################################################################
#
#
#
#
##############################################################################################################################################################

exit 0;
