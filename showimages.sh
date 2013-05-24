#!/bin/bash

echo "mounting usb"
sudo /home/pi/mountusb.sh

# copy images
echo "copy hillsong1.jpg"
cp /home/pi/usbmount/hillsong1.jpg /home/pi/images/

echo "unmount usb"
sudo /home/pi/unmountusb.sh

echo "showing images/hillsong1.jpg"
/usr/bin/fbi -a -noverbose /home/pi/images/hillsong1.jpg
