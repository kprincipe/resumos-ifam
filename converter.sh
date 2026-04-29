#!/usr/bin/bash

pastas_str=$(ls)
pastas=()

for i in $pastas_str; do pastas+=($i) ; done

for pasta in ${pastas[@]}; do
    if [ -d $pasta ]; then

        echo "${pasta}"
    fi
done
