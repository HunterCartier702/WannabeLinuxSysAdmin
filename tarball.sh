#!/usr/bin/env bash

# Mostly useless script, but good practice

echo "****Archive and Compress***"
echo -e "Enter compression type to use: \n"

echo "1 for .gzip"
echo "2 for .bzip2"
echo "3 for .xz"
echo "4 for .lz"
echo -e "q to exit \n"

read -p "Enter number for option: " comp

case $comp in 
	1) echo "$comp .gzip" ;;
	2) echo "$comp .bzip2" ;;
	3) echo "$comp .xz" ;;
	4) echo "$comp .lz" ;;
	q) echo "Quitting..";exit 0 ;;
	*) echo "Invalid input";exit 1 ;;
esac

read -p "Enter directory or file to be archived and compressed: " zipped

# Check if the file or directory exists
if [[ ! -e "$zipped" ]]; then
    echo "The specified file or directory does not exist. Exiting.."
    exit 1
# Check if directory and then user permissions
elif [[ -d "$zipped" ]];then
	if [[ -r "$zipped" && -x "$zipped" ]];then
		echo -e "\"$USER\" can archive and compress \""$zipped"\". Continuing...\n"
	else
		echo "You dont have correct perms over "$zipped""
		exit 1
	fi
# Check if file and then user permissions
elif [[ -f "$zipped" ]];then 
	if [[ -r "$zipped" ]];then
		echo -e "\"$USER\" can archive and compress \""$zipped"\". Continuing...\n"
	else 
		echo "You don't have correct perms over "$zipped""
		exit 1
	fi
else
	echo "Error"
	exit 1
fi

# Strip any '/'s and parts of path if any
base="$(basename "$zipped")"

# Ask for output directory (optional)
read -p "Enter output directory (e.g., /home/user/backups Press 'Enter' for current directory.): " outdir

# Check if directory exists and then permissions
if [[ -z "$outdir" ]];then
	outdir="."  # Use current directory if none provided
elif [[ ! -d "$outdir" ]];then
	echo "Directory "$outdir" doesn't exist"
	exit 1
elif [[ -w "$outdir" && -x "$outdir" ]];then
	echo "Copying "$zipped" to "$outdir""
else 
	echo "You need write and execute perms on "$outdir""
	exit 1
fi

echo -e "\n#########################################\n"
# Archive and compress
case $comp in
	1)
		output="$outdir/$(date +%F)_$base.tar.gz"
		echo "Archive $output created from:"
		tar -czvf "$output" "$zipped"
		;;
	2)
		output="$outdir/$(date +%F)_$base.tar.bz2"
		echo "Archive $output created from:"
		tar -cjvf "$output" "$zipped"
		;;
	3)
		output="$outdir/$(date +%F)_$base.tar.xz"
		echo "Archive $output created from:"
		tar -cJvf "$output" "$zipped"
		;;
	4)
		output="$outdir/$(date +%F)_$base.tar.lz"
		echo "Archive $output created from:"
		tar -lzip -cvf "$output" "$zipped"
		;;
esac
