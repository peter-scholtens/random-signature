#!/bin/bash
THUNDERBIRD_DIR=$HOME"/.thunderbird/"
STOCK_DIR=$THUNDERBIRD_DIR"random-signature/stock"
THUNDERBIRD_FIFO=$THUNDERBIRD_DIR"random_signature_fifo.html"
while true; do
	SIG_FILES=($(ls -1 $STOCK_DIR/*))
	SIGNUM=${#SIG_FILES[@]}
	declare -A AGE_DAYS
	# For all signature files, find out their age expressed in days.
	for FILE in "${SIG_FILES[@]}"; do
		AGE_DAYS[$FILE]=$(( ($EPOCHSECONDS - $( stat -c "%Y" $FILE ))/(3600*24) ))
	done
	# Find highest values of all days.
	HIGHEST=0
	for FILE in "${!AGE_DAYS[@]}"; do
		AGE_ITEM=${AGE_DAYS[$FILE]}
		if [[ $AGE_ITEM -gt $HIGHEST ]]; then
			HIGHEST=$AGE_ITEM
		fi
	done
	# Replace all values wil highest divided by previous value, truncated.
	SUM=0
	for FILE in "${!AGE_DAYS[@]}"; do
		NEW_VAL=$(( $HIGHEST / ${AGE_DAYS[$FILE]} ))
		AGE_DAYS[$FILE]=$NEW_VAL
		SUM=$(($SUM + $NEW_VAL))
	done
	RND=$(($RANDOM%$SUM))
	PART_SUM=0
	SEL_INDEX=-1
	while [[ $PART_SUM -lt $RND ]]; do
		SEL_INDEX=$(( $SEL_INDEX + 1 ))
		ITEM=${SIG_FILES[$SEL_INDEX]}
		PART_SUM=$((  $PART_SUM  + ${AGE_DAYS[$ITEM]} ))
	done
	SELECTED=${SIG_FILES[$SEL_INDEX]}
	ln -s $SELECTED $THUNDERBIRD_FIFO
	echo "Linked to "$SELECTED
	sleep 10
	rm $THUNDERBIRD_FIFO
done
