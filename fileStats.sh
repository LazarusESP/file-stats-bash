#!/bin/bash

AnalizaTekstu() {

source=$1
output=$2

if ! [[ -e $source ]]; then
 echo "plik nie istnieje"
 exit -1
fi

if ! [[ -r $source ]]; then
 echo "nie masz prawa do odczytu tego pliku"
 exit -1
fi

if ! [[ -e $output ]]; then
 if touch $2 ; then
  echo "stworzono plik docelowy"
 else 
  echo "nie mozna utworzyc pliku"
  exit -1
 fi
else 
 > "$2"
 if ! [[ -w  $output ]]; then
  echo "nie masz prawa zapisu"
  exit -1
  fi
fi

declare -A array

for word in $(cat $1); do
    if [[ ${array[$word]} ]]; then
        ((array[$word]++))
    else
        array[$word]=1
    fi
done

for word in "${!array[@]}"; do
    echo "$word:${array[$word]}" >> "$2"
  done

sort -t ":" -k2 -nr -o $2 $2

}

AnalizaTekstu $1 $2

