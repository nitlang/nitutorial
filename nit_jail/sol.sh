#!/bin/bash
for ans in out/*/ans*; do
	dir=`dirname "$ans"`
	ip=`grep IP "$dir"/clientinfo`
	#file=`grep compile "$dir"/log | awk '{ print $3 }'`
	file=`grep FLAG "$dir"/log | awk '{ print $2 }'`
	file=`basename $file`
	lc=`wc -l $dir/$file | awk '{print $1 / 2}'`
	goal=`wc -l ../$file | awk '{print $1}'`
	echo "$ip $dir/$file $lc $goal"
done
