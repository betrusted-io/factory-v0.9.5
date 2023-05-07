#!/bin/bash
set -e

echo "power on"
sudo ./vbus.sh 1

echo "erasing residual EC and WF200 staging artifacts"
sudo ./usb_update.py -e precursors/blank_ec.bin
sudo ./usb_update.py -w precursors/blank.bin

echo "power back on"
sudo ./vbus.sh 1

echo "provision EC"
sudo ../fomu-flash/fomu-flash -w precursors/wfm_wf200_C0.sec -a 0x9C000 && sudo ../fomu-flash/fomu-flash -r
sleep 0.5
sudo ../fomu-flash/fomu-flash -4 && sudo ../fomu-flash/fomu-flash -w precursors/bt-ec.bin && sudo ../fomu-flash/fomu-flash -r 
sleep 0.5
sudo ./reset_ec.sh

echo "provision SoC"
sudo ./reset_soc.sh

cd jtag-trace && ./jtag_gpio.py -f ../precursors/loader.bin --raw-binary -a 0x500000 -s -r -n
cd ..

cd jtag-trace && ./jtag_gpio.py -f ../precursors/xous.img --raw-binary -a 0x980000 -s -r -n
cd ..

cd jtag-trace && ./jtag_gpio.py -f ../precursors/soc_csr.bin --raw-binary -a 0x280000 --spi-mode -r -n
cd ..

sudo ./reset_soc.sh

echo "Rollback staged"
echo "Reminder: must force a SoC update before the rollback is complete"
