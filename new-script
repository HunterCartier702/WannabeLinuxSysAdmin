#!/usr/bin/env bash
# Create 1 or more blank bash script templates
# Add to /usr/local/bin if it is in your $PATH for quick access

function usage
{
	# Strip off the full path and "pretty print" only the script name itself
	script=${0##*/}
	echo "Usage: $script $@"
}

if [[ $# -lt 1 || "$1" == "-h" || "$1" == "--help" ]];then
	usage "<arg1>" "[arg2...]"
	exit
fi

for arg in "$@";do
	if [ -a "$arg" ];then
		echo -e "\n$arg already exists, skipping..\n"
		continue
	else
		echo -e '#!/usr/bin/env bash\n' > "$arg"
		chmod u+x "$arg"
		echo "------------------"
		echo -e "Created $arg\nContents:"
		cat "$arg"
		echo "------------------"
	fi
done
