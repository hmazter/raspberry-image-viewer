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
	rm $USBDIR/*.jpg
	rm $USBDIR/*.png

	# copy images
	echo "copy *.jpg and *.png from USB"
	cp $USBDIR/*.jpg $IMGDIR/
	cp $USBDIR/*.png $IMGDIR/
else
	echo "USB NOT found, using current images"
fi

echo "unmount usb"
umount $USBDIR

sleep 1

echo "showing 5 second slideshow with images/*.jpg images/*.png"
/usr/bin/fbi -a -noverbose -t 5 $IMGDIR/*.jpg $IMGDIR/*.png
