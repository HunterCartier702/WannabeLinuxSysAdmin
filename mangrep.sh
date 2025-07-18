#!/bin/bash

# I added this to my $PATH so I can call it from anywhere
# I personally think it is useful if you are curious about a flag from a man page and just want to check it fast.
# I would manually type this command out all the time 

# Example: man tar | grep -A2 "\-C"

read -p "Enter tool: " tool
read -p "Enter flag: " flag

man $tool | grep -A2 "\\-$flag"
