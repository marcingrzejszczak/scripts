#!/bin/sh
test -f /usr/share/acpi-support/key-constants || exit 0

. /usr/share/acpi-support/key-constants

# DeviceConfig

if [ "$model" != "701" ] ; then
	# On an Eee PC (ASUSTeK model 701) the keys in the range handled by this
	# script have entirely different meanings. They are handled in separate
	# scripts.
	acpi_fakekey $KEY_BRIGHTNESSUP
fi

# added per http://forum.notebookreview.com/showpost.php?p=5665108&postcount=1235
#brightness=`echo $3 | sed 's/0000001//'`
#setpci -s 00:02.0 F4.B=${brightness}f

# added per mailing list post
# in /etc/asus_brn_up.sh
brightness=$((0x`setpci -s 00:02.0 F4.B`+16));
if [ $brightness -gt $((0xff)) ] ; then
  brightness=$((0xff));
fi
setpci -s 00:02.0 F4.B=`printf '%x' $brightness`;
