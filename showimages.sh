#!/bin/bash

USBDIR="/home/pi/usbmount"
IMGDIR="/home/pi/images"

echo "mounting usb"
sudo mount -t vfat -o rw,users /dev/sda1 $USBDIR

# if usb folder is not empty (a usb with files on it is mounted)
if [ "$(ls -A $USBDIR)" ]
then
	echo "USB found, copying new images"

	# remove all old files
	rm $IMGDIR/*.jpg
	rm $IMGDIR/*.png

	# copy images
	echo "copy *.jpg and *.png from USB"
	cp $USBDIR/*.jpg $IMGDIR/
	cp $USBDIR/*.png $IMGDIR/
else
	echo "USB NOT found, using current images"
fi

echo "unmount usb"
umount $USBDIR

sleep 2

filesstring=""

# check for files in image dir
jpgfiles=`ls -1 $IMGDIR/*.jpg 2>/dev/null | wc -l`
pngfiles=`ls -1 $IMGDIR/*.png 2>/dev/null | wc -l`

if [ $jpgfiles = 0 ] ; then
	if [ $pngfiles = 0 ] ; then
		echo "no images files found, aborting"
		exit 0
	fi
fi 

if [ $jpgfiles != 0 ]; then 
	echo "found jpg"
	filesstring="$filesstring $IMGDIR/*.jpg"
fi

if [ $pngfiles != 0 ]; then 
	echo "found png"
	filesstring="$filesstring $IMGDIR/*.png"
fi

echo "showing 5 second slideshow with $filesstring"
/usr/bin/fbi -a -noverbose -t 5  $filesstring
