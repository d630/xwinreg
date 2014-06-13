#!/usr/bin/env bash

read -r _ _ _ _ xids < <(xprop -root _NET_CLIENT_LIST) && printf '%s\n' ${xids//,/}
