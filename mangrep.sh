#!/bin/bash

# I aded this to my $PATH so I can call it from anywhere
# I personally think it is useful if you are curious about a flag from a man page and just want to check it fast.
# I would type this command out all the time 
# If you're always doing something more than once than why not automate it no matter how simple

# Example: man tar | grep -C2 "\-C"

read -p "Enter tool: " tool
read -p "Enter flag: " flag

man $tool | grep -C2 "\\-$flag"
