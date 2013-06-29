#!/bin/bash

echo "mounting usb"
sudo /home/pi/mountusb.sh

# copy images
echo "copy *.jpg from USB"
cp /home/pi/usbmount/*.jpg /home/pi/images/

echo "unmount usb"
sudo /home/pi/unmountusb.sh

echo "showing 5 second slideshow with images/*.jpg"
/usr/bin/fbi -a -noverbose -t 5 /home/pi/images/*.jpg
