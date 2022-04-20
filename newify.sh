#!/bin/bash
set -e

echo "power on"
sudo ./vbus.sh 1

echo "erasing SOC flash"
cd jtag-trace && ./jtag_gpio.py -f precursors/blank.bin --erase -a 0 --erase-len=0xf80000 -r

cd ..

echo "erasing EC flash"
sudo ../fomu-flash/fomu-flash -w precursors/blank.bin

sleep 2

echo "power off"
sudo ./vbus.sh 0

sleep 2

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

cd jtag-trace && ./jtag_gpio.py -f ../precursors/loader.bin --raw-binary -a 0x500000 -s -r
cd ..

cd jtag-trace && ./jtag_gpio.py -f ../precursors/xous.img --raw-binary -a 0x980000 -s -r -n
cd ..

cd jtag-trace && ./jtag_gpio.py -f ../precursors/soc_csr.bin --raw-binary --spi-mode -r
cd ..

sudo ./reset_soc.sh

echo "newify complete"

