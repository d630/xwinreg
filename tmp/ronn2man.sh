#!/usr/bin/env bash

_pwd=$(pwd)
cp -- "$1" "${1%.*}.ronn"
ronn --roff "${1%.*}.ronn"
rm -- "${1%.*}.ronn"
mv -- "${1%.*}.1" "${_pwd%/*}/doc/man/"
man -l "${_pwd%/*}/doc/man/${1%.*}.1"
