#!/usr/bin/env bash

for i in *.1
do
    man -l ./${i} | sed -r 's/\d027\[[0-9]+m//g' > ${i}.txt
done
