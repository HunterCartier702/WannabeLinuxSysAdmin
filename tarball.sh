#!/bin/bash

# Mostly useless script, but good practice

echo "****Archive and Compress***"
echo -e "Enter compression type to use: \n"
echo "1 for .gzip"
echo "2 for .bzip2"
echo "3 for .xz"
echo -e "q to exit \n"

read -p "Enter option: " comp

if [[ "$comp" == "q" ]];then
	exit 0
elif [[ "$comp" =~ ^[1-3]$ ]];then
	:
else
	echo "Invalid input"
	exit 1
fi

read -p "Enter directory or file to be archived and compressed: " zipped

# Check if the file or directory exists
if [[ ! -e "$zipped" ]]; then
    echo "The specified file or directory does not exist. Exiting.."
    exit 1
elif [[ ! -r "$zipped" && ! -x "$zipped" ]];then  # Check user permissions on file
	echo "You don't have perms over file. Try running as root. Exiting.."
	exit 1
else
	echo -e "File \""$zipped"\" exists and \"$USER\" has correct perms to archive and compress file. Continuing...\n"
fi

# Get the base name of the file/folder (without path)
base="$(basename "$zipped")"

# Ask for output directory (optional)
read -p "Enter output directory (e.g., /home/user/backups Press 'Enter' for current directory.): " outdir
outdir="${outdir:-.}"  # Use current directory if none provided

echo -e "\n#########################################\n"

case $comp in
	1)
		output="$outdir/$(date +%Y-%m-%d)_$base.tar.gz"
		echo "Archive $output created from:"
		tar -czvf "$output" "$zipped"
		;;
	2)
		output="$outdir/$(date +%Y-%m-%d)_$base.tar.bz2"
		echo "Archive $output created from:"
		tar -cjvf "$output" "$zipped"
		;;
	3)
		output="$outdir/$(date +%Y-%m-%d)_$base.tar.xz"
		echo "Archive $output created from:"
		tar -cJvf "$output" "$zipped"
		;;
esac
