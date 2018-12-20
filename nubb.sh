#!/bin/bash

# c0ded by : shutdown57 - alinko kun
# copyright (c) JavaCodeRulez 2017
# Thx for nice idea : RobinRoot a.k.a Bagas Homo
# fb.com/JKT48.co
######################################################
# Last Modified : 20 Mei 2017 - 17:54 WIB
# Error Found : "M: bad interpreter: No such file or directory"
# Reference : http://stackoverflow.com/questions/14219092/bash-my-script-bin-bashm-bad-interpreter-no-such-file-or-directory

resize -s 100 100 > /dev/null
m="\033[1;31m"
k="\033[1;33m"
h="\033[1;32m"
b="\033[1;34m"
n="\033[1;37m"
h1="\033[0;32m"

s57i(){
	echo -e $b"[!] "$n $1 
}
s57d(){
	echo -e $m"[-] "$n $1
}
s57w(){
	echo -e $k"[x] "$n $1
}
s57s(){
	echo -e $h"[+] "$n $1
}
s57t(){
	echo -e -n $h1"[?] "$n $1 $m"::"$k"::"$n
	read $2
}

s57load69(){
	clear
s57d "Jancox --->"
sleep 0.5
clear
s57w "jAncox ------>"
sleep 0.5
clear
s57s "jaNcox --------->"
sleep 0.5
clear
s57i "janCok ------------>"
sleep 0.5
clear
s57d "jancOk --------------->"
sleep 0.5
clear
s57d "jancoK ------------------>"
sleep 0.5
clear
}
s57banner()
{
clear
s57d "+--=====[[ JanCox Tools | @RobinRoot ..... !!"
sleep 1
s57d "+--=====[[ c0ded by : shutdown57 ......... !!"
sleep 1
s57d "+--=====[[ github : @alintamvanz ......... !!"
sleep 1
s57load69
}
s57help()
{
printf "
"$m"     ____.             _________                "$n" ___________           .__          
"$m"    |    |____    ____ \_   ___ \  _______  ___ "$n" \__    ___/___   ____ |  |   ______
"$m"    |    \__  \  /    \/    \  \/ /  _ \  \/  / "$n"   |    | /  _ \ /  _ \|  |  /  ___/
"$m"/\__|    |/ __ \|   |  \     \___(  <_> >    <  "$n"   |    |(  <_> |  <_> )  |__\___ \ 
"$m"\________(____  /___|  /\______  /\____/__/\_ \\ "$n"   |____| \____/ \____/|____/____  >
"$m"              \/     \/        \/            \/ "$n"                                 \/
"$h"+---------------------||"$b" JanCox Your Self -"$n" indonesianpeople.shutdown57@gmail.com :\"


"$b"[!]"$n" ./jancox --email-gen       : Generate Email with your own users list and passwords list
"$b"[!]"$n" ./jancox --email-filter    : Filter Email (gmail,yahoo,outlook,hotmail)
"$b"[!]"$n" ./jancox --email-valid     : Check Live or die email with amazon validation
"
}
s57_cekfile(){
	if [[ $1 == "" || $2 == "" ]]; then
		s57d "Someting Wrong Beibeh .."
		exit 1
	fi
cat $1 > /dev/null 2>&1
if [[ $? -eq 0 ]]; then
	s57s "File : "$1".......... OK !!"
else
	s57d "File : "$1".......... KO !!"
	exit 0
fi
if [[ $2 != "" ]]; then

	cat $2 > /dev/null 2>&1
	if [[ $? -eq 0 ]]; then
		s57s "File : "$2".......... OK !!"
	else
		s57d "File : "$2".......... KO !!"
		exit 0
	fi
fi
}
s57save()
{
	touch $2
	echo $1 >> $2
}
s57_emailgen()
{
	s57load69
	s57i "Email Generator ..."
	sleep 1
	s57t "User list  " user
	s57t "Domain list" domen
	s57t "Save as    " save
	s57_cekfile $user $domen
	userl=`cat $user`
	domenl=`cat $domen`
	userm=$(echo $userl | tr "\n" "\n")
	domenm=$(echo $domenl | tr "\n" "\n")
	for u in $userm
	do
		s57i "---[ "$u" ]---"
		for e in $domenm
		do
			email=$u"@"$e
			s57s $email
			sleep 0.2
			s57save $email $save
		done
	done
	if [[ -f $save ]]; then
		s57i "+-----------[ File result saved to "$save" ... !"
	else
		s57d "+-----------[ File result not saved :( , Maybe directory not writable !"
	fi

}
s57_emailvalid()
{
	s57load69
	s57i "Email Valid Checker ..."
	sleep 1
	s57t "Email list " lo
	em=`cat $lo`
	p=$(echo $em | tr "\n" "\n")
	for ppq in $p
	do
	wget -q "https://www.amazon.com/ap/register?_encoding=UTF8&openid.assoc_handle=usflex&openid.claimed_id=http%3A%2F%2Fspecs.openid.net%2Fauth%2F2.0%2Fidentifier_select&openid.identity=http%3A%2F%2Fspecs.openid.net%2Fauth%2F2.0%2Fidentifier_select&openid.mode=checkid_setup&openid.ns=http%3A%2F%2Fspecs.openid.net%2Fauth%2F2.0&openid.ns.pape=http%3A%2F%2Fspecs.openid.net%2Fextensions%2Fpape%2F1.0&openid.pape.max_auth_age=0&openid.return_to=https%3A%2F%2Fwww.amazon.com%2Fgp%2Fyourstore%2Fhome%3Fie%3DUTF8%26ref_%3Dgno_newcust?&email=${ppq}" -O tmp/azon.txt
	cat tmp/azon.txt | grep "Create account" > /dev/null;cek=$?
	if [[ $cek -eq 0 ]]; then
			s57d "[ Not Valid ] : "$ppq >> log_jancokTools.txt
	else
			s57s "[ Valid ] : "$ppq >> log_jancokTools.txt
			echo $ppq >> result_jancokTools.txt
	fi
	done
rm -rf tmp/azon.txt
}
s57_emailfilter()
{
	s57load69
	s57i "Email Filter ..."
	sleep 1
	s57t "Email list " emlist
	s57t "Create Directory Result " dira
	mkdir $dira > /dev/null 2>&1
	s57_cekfile $emlist $emlist
	em=`cat $emlist`
	m=$(echo $em | tr "\n" "\n")
	
	for o in $m
	do
		echo $o | grep "yahoo" >> $dira/email-yahoo.txt
	done
	for i in $m
	do
		echo $i | grep "gmail" >> $dira/email-gmail.txt
	done
	for u in $m
	do
		echo $u | grep "outlook" >> $dira/email-outlook.txt
	done
	for h in $m
	do
		echo $h | grep "hotmail" >> $dira/email-hotmail.txt
	done

	if [[ -f $dira/email-yahoo.txt ]]; then
		s57i "__________[ Yahoo Result ]__________"
		sleep 0.8
		cat $dira/email-yahoo.txt
	else
		s57d "__________[ Yahoo Result Not Found ]__________"
	fi
	if [[ -f $dira/email-gmail.txt ]]; then
		s57i "__________[ Gmail Result ]__________"
		sleep 0.8
		cat $dira/email-gmail.txt
	else
		s57d "__________[ Gmail Result Not Found ]__________"
	fi
	if [[ -f $dira/email-outlook.txt ]]; then
		s57i "__________[ Outlook Result ]__________"
		sleep 0.8
		cat $dira/email-outlook.txt
	else
		s57d "__________[ Outlook Result Not Found ]__________"
	fi
	if [[ -f $dira/email-hotmail.txt ]]; then
		s57i "__________[ Hotmail Result ]__________"
		sleep 0.8
		cat $dira/email-hotmail.txt
	else
		s57d "__________[ Hotmail Result Not Found ]__________"
	fi
}

case $1 in
	"--email-gen" )
s57_emailgen
		;;
	"--email-filter")
s57_emailfilter
		;;
	"--email-valid" )
s57_emailvalid
		;;
		*)
s57banner
s57help
esac