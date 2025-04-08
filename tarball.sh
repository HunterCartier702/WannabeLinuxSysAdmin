#!/bin/bash

# Mostly useless script, but good practice

echo "*Archive and compress*"
echo "Enter compression type to use: "
echo "1 for .gzip"
echo "2 for .bzip2"
echo "3 for .xz"
echo "q to exit"

read -p "Enter option: " comp

if [[ "$comp" == "q" ]]; then
	exit 0
elif [[ "$comp" =~ ^[1-3]$ ]]; then
	:
else
	echo "Invalid input"
	exit 1
fi

read -p "Enter directory or file to be archived and compressed: " zipped

# Check if the file or directory exists
if [[ ! -e "$zipped" ]]; then
    echo "The specified file or directory does not exist."
    exit 1
fi

# Get the base name of the file/folder (without path)
base="$(basename "$zipped")"

# Ask for output directory (optional)
read -p "Enter output directory (e.g., /home/user/backups Press 'Enter' for current directory and skip.): " outdir
outdir="${outdir:-.}"  # Use current directory if none provided

case $comp in
	1)
		output="$outdir/$(date +%Y-%m-%d)_$base.tar.gz"
		echo "Creating archive: $output"
		tar -czvf "$output" "$zipped"
		;;
	2)
		output="$outdir/$(date +%Y-%m-%d)_$base.tar.bz2"
		echo "Creating archive: $output"
		tar -cjvf "$output" "$zipped"
		;;
	3)
		output="$outdir/$(date +%Y-%m-%d)_$base.tar.xz"
		echo "Creating archive: $output"
		tar -cJvf "$output" "$zipped"
		;;
esac
