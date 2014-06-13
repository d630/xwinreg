#!/usr/bin/env bash

for i in *.1
do
    echo gzip -c "$i" > /usr/share/man/man1/${i##*/}.gz
done
