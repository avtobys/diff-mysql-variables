#!/usr/bin/env bash

if [[ -z "$1" || -z "$2" ]]; then
    echo "Requires 2 parameters!"
    exit 1
fi

if [ ! -f "$1" ]; then
    echo "File \"$1\" not exists"
    exit 1
fi

if [ ! -f "$2" ]; then
    echo "File \"$2\" not exists"
    exit 1
fi

v1=$(grep '^|' $1 | sed -r 's/\s*//g' | cut -d'|' -f2-3)
v2=$(grep '^|' $2 | sed -r 's/\s*//g' | cut -d'|' -f1-4)

printf "Mismatched variables:\n\n"
echo "Value | $1 | $2"

for str_1 in $(echo $v1); do
    k_1=$(echo $str_1 | cut -d'|' -f1)
    val_1=$(echo $str_1 | cut -d'|' -f2)
    IFS=''
    str_match=$(echo $v2 | grep "|${k_1}|")
    val_2=$(echo $str_match | cut -d'|' -f3)
    if [[ -n "$str_match" && "$val_2" != "$val_1" ]]; then
        echo "$k_1 | $val_1 | $val_2"
    fi
done


