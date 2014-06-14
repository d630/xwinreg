#!/usr/bin/env bash

for i in *.1
do
    gzip -c "$i" > /usr/share/man/man1/${i##*/}.gz
done
