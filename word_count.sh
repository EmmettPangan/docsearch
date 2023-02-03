#!/bin/bash

# Check if a file name was provided as an argument
if [ $# -ne 1 ]; then
  echo "Usage: $0 <filename>"
  exit 1
fi

# Store the file name in a variable
file=$1

# Create a temporary file to store the sorted words
temp_file=$(mktemp)

# Convert all the words in the file to lowercase, sort them and store in the temporary file
cat $file | tr '[:upper:]' '[:lower:]' | tr -s '[:space:]' '[\n*]' | sort | uniq -c | sort -n > $temp_file

# Read the temporary file line by line and display the word count and word
while read line; do
  count=$(echo $line | awk '{print $1}')
  word=$(echo $line | awk '{print $2}')
  echo "$count $word"
done < $temp_file

# Remove the temporary file
rm $temp_file