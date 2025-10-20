#!/bin/bash

# Write an ISO to USB
# I have a directory full of iso's and I am always trying new distros. This help automate some of the task

info()
{
    echo -e "\n\033[1;32m==> $*\033[0m"
}

read -rp "Enter directory containing ISO image: " iso_dir

if [[ ! -d "$iso_dir" ]];then
	echo "Directory not found"
	exit 1
fi

mapfile -t iso < <(find "$iso_dir" -maxdepth 1 -type f -name "*.iso")

if [[ ${#iso[@]} -eq 0 ]];then
	echo "No iso files in $iso_dir"
	exit 1
fi

info "Available iso's in $iso_dir:"
for i in "${!iso[@]}";do
	echo "[$i] ${iso[$i]}"
done

read -rp "Enter the number of the ISO to write to USB: " iso_num

img=${iso[$iso_num]}

info "Available devices: "
lsblk -lp
echo

read -rp "Enter device path (e.g. /dev/sdb): " device

info "Your final selections:"
echo "ISO:	  $img"
echo "Device:  $device"
read -rp "This will erase all data on $device! Continue? (y/N): " confirm

if [[ "$confirm" != [yY] ]];then 
	echo "Aborted"
	exit 1
fi

info "Writing to $device..."
sudo dd if="$img" of="$device" bs=4M status=progress conv=fsync

info "Ejecting $device..."
sudo eject "$device"

info "Finished writing $img to $device"
