#!/bin/bash
msg=$(python genmsg.py $1 $2)
if [ "$?" != "0" ]; then
  echo $msg
  exit $?
fi

hciconfig hci0 up
hcitool cmd 0x08 0x000a 00
hcitool cmd 0x08 0x0008 $msg
hcitool cmd 0x08 0x000a 01
