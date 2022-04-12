# ShellOgreONION
Unofficial ShellOgreONION Shell Script.

Not done yet, lightly tested. Use with great CAUTION.
This software is not associated with nor endorsed by DeepOnion© or TradeOgre© who shall be held harmless for use or misuse of this product.
This SOFTWARE PRODUCT is provided by THE PROVIDER "as is" and "with all faults." THE PROVIDER makes no representations or warranties of any kind 
concerning the safety, suitability, lack of viruses, inaccuracies, typographical errors, or other harmful components of this SOFTWARE PRODUCT. 
There are inherent dangers in the use of any software, and you are solely responsible for determining whether this SOFTWARE PRODUCT is compatible 
with your equipment and other software installed on your equipment. You are also solely responsible for the protection of your equipment and backup 
of your data, and THE PROVIDER will not be liable for any damages you may suffer in connection with using, modifying, or distributing this SOFTWARE PRODUCT.
----------------------------------------------------------------------------------------------------------------------------------------------------
To use this script you need an account at TradeOgre https://tradeogre.com/ . You also need to have API key and secret. The key and secret will go on 
the first and only line of the file named shellogreks.txt . The line will look like key:secret  with a colon between the two and no spaces or CRLF at 
the end of the line (do not hit ENTER). Save file in same folder where script is located. Make sure the script is executable 
(chmod +x shellogreONION.sh).
This script has only been tested on Debian Linux (Buster) using Konsole terminal emulator. You will need 'curl' which is likely already installed and 
'jq' (sudo apt-get install jq) to run this script. If your system asks for anythng else you will need to install that also (please let me know as well).
Navigate to the folder with the script and enter ./shellogreONION.sh . Several responses have defaults so you can just hit ENTER if that works for you.
Defults can be identified with square brackets [BTC-ONION] . For buy and sell, you have unlimited chances to change responses and then one chance to 
accept or abort the transaction. You can also <CTRL-C> to abort the script at any time. 

You can use this script to get info and buy/sell for any trading pair on TradeOgre by not accepting defaults and typing in appropriate info. For now I
have left the coin balance (#2) as ONION mostly because I love ONION :) I will likely make this dynamic with ONION default depending on feedback.
  
Please read and understand the API calls before using the script https://tradeogre.com/help/api If you are new to scripts and/or APIs you can try out
all the options except 3 and 4 (buy/sell) to see how things work first. 
  
I have doubts that this script will work as is on Mac and know it will not work as is on Windows. As I do not have those platforms to test on I will
likely never make a version for them. But feel free to fork it and make changes if you wish.
  
I appreciate any and all feedback as far as usability, any errors, suggestions for new features or changes to existing features. Feel free to submit 
a PR on the github if you have any ideas of your own and have ready to go (tested) code in your fork. 

![menu_20220406_071917](https://user-images.githubusercontent.com/36109325/161964234-4b2f0384-9129-4fe2-a844-757ac842068d.png)


CREDIT: This script stolen from : https://github.com/ShellCrypto/ShellOgre
