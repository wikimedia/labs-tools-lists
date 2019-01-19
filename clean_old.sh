#!/bin/bash

BASE="output"

for dir in $(find $BASE -type d); do
  for file in $(find $dir -maxdepth 1 -type f | sort |head -n -3); do
    rm $file
  done
done
