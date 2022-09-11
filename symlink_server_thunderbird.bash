#!/bin/bash
THUNDERBIRD_DIR=$HOME"/.thunderbird/"
STOCK_DIR=$THUNDERBIRD_DIR"random-signature/stock"
THUNDERBIRD_FIFO=$THUNDERBIRD_DIR"random_signature_fifo.html"
while true; do
	SIGFILES=($(ls -1 $STOCK_DIR/*))
	SIGNUM=${#SIGFILES[@]}  
	NUM=$(($RANDOM%$SIGNUM))
	SELECTED=${SIGFILES[$NUM]}
	ln -s $SELECTED $THUNDERBIRD_FIFO
	echo "Linked to "$SELECTED
	sleep 10
	rm $THUNDERBIRD_FIFO
done
