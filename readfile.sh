#!/bin/bash
while IFS=$'\t' read -r title tags link
do
  tags='#'"${tags}"
  printf "$title\n"
  printf "$tags\n"
  printf "$link\n\n"
done < <(paste FB_title.txt FB_tags.txt FB_link.txt)

