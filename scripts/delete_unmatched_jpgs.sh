#!/bin/bash

# Check for correct number of arguments
if [ "$#" -ne 2 ]; then
  echo "You must enter exactly 2 directories"
  exit 1
fi

dir1="$1"
dir2="$2"

# Check if directories exist
if [ ! -d "$dir1" ]; then
  echo "Directory $dir1 does not exist."
  exit 1
fi

if [ ! -d "$dir2" ]; then
  echo "Directory $dir2 does not exist."
  exit 1
fi

# Loop through *.JPG files in directory 1
for jpgFile in "$dir1"/*.JPG; do
  # Extract file base name (without extension)
  baseName=$(basename "$jpgFile" .JPG)

  # Check if corresponding *.RAF file exists in directory 2
  if [ ! -f "$dir2/$baseName.RAF" ]; then
    # If not, delete the JPG file from directory 1
    echo "Deleting $jpgFile"
    rm "$jpgFile"
  fi
done

exit 0
