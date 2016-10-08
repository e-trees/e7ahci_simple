#!/bin/bash

for i in 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28
do
	a=$((2**$i))
	./seq $a
	./seq_read $a
done
