#!/bin/bash
while true; do
	FIFO=my_random_signature
	NUM=$(($RANDOM%4))
	mkfifo $FIFO
	case $NUM in
		1)
		REPLY="Hello World!"
		;;
		2)
		REPLY="Good day!"
		;;
		*)
		REPLY="How are you?"
		;;
	esac
	echo $REPLY > $FIFO
	rm $FIFO
done
