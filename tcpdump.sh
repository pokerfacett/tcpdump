#!/bin/bash
declare -a name
test=`ifconfig | grep '^eth[0-9]' | awk 'BEGIN {count=0;} {count++;} END{print count}'`
for ((i=0;i<test;i++))
do
	name[$i]=`ifconfig | grep '^[ev][mn][0-9e]t\?[^.][0-9]\{0,\}'| awk '{print $1}'`
	mkdir -p ${name[$i]}
	cd ${name[$i]}
	filename=result_`date +%s`.cap
	touch $filename
	chmod o+r $filename
	tcpdump -i ${name[$i]} -w $filename -C 1 &
done
