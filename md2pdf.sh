#!/usr/bin/env bash

input_name=$(echo $1 | cut -d '.' -f 1)

# if [[ $2 == '' ]]; then
#     printf "Usage: %s <input.md> <output.md>\n" $(basename $0)
#     exit 1
# fi

pandoc -o $input_name.pdf -V geometry:"top=3cm, bottom=2cm, left=3cm, right=2cm" -V fontsize:10pt --from markdown --to pdf $input_name.md --toc
#pandoc -o $input_name.pdf --from markdown --to pdf $input_name.md --toc
