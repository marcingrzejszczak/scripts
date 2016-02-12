#!/bin/sh

test -f /usr/share/acpi-support/key-constants || exit 0
. /usr/share/acpi-support/key-constants
acpi_fakekey $KEY_BRIGHTNESSDOWN

# added per http://forum.notebookreview.com/showpost.php?p=5665108&postcount=1235
#brightness=`echo $3 | sed 's/0000002//'`
#setpci -s 00:02.0 F4.B=${brightness}f

# added per mailing-list post
brightness=$((0x`setpci -s 00:02.0 F4.B`-16));
if [ $brightness -lt 0 ] ; then
   brightness=1;
fi
setpci -s 00:02.0 F4.B=`printf '%x' $brightness`;
