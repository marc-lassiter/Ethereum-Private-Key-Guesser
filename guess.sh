#!/bin/bash  
search_guess () {
	#generate a random hex (64 characters)
	n=32
	g=$(hexdump -vn "$n" -e ' /1 "%02x"' /dev/urandom) # ; echo
	#echo "$g"

	#try it
	#a=$(geth account import <(echo "$g") & echo -en "\n\n" & echo -en "\n\n") 
	a=$(geth account import --password ~/guesser/password.txt  <(echo "$g"))
	#a: Address: {4b4bc924bfc073af1aa0ed534e4d2d835e170424}
	#wait
	#echo -en "\n\n" #enter twice
	#wait

	#parse the address out
	b=$(echo "$a" | sed 's/Address: {//1' | tr --delete "}")
	#echo "$b"

	#wait

	#see if the address has a balance
	c=$(curl -H "Content-Type: application/json" --data '{"jsonrpc":"2.0", "method":"eth_getBalance", "params":["0x'"$b"'", "latest"], "id":1}' http://localhost:8545)
	#echo "$c"

	#wait

	#parse the balance out
	#{"jsonrpc":"2.0","id":1,"result":"0x0"}
	d=$(echo "$c" | sed 's\{"jsonrpc":"2.0","id":1,"result":"\\1' | tr --delete '"}')
	#echo "$d"

	#if has a balance write to found log
	if [[ $d != "0x0" ]]; then
		echo "FOUND ONE";
		echo "Address: $b, Private Key: $g and Balance: $d" >> ~/guesser/goodlog
	fi

	#run again
	search_guess
}
search_guess
