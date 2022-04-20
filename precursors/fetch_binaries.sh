#!/bin/bash
set -e

echo "Updating to v0.9.5 stabilized release"

wget --no-check-certificate  https://ci.betrusted.io/releases/v0.9.5/loader.bin -O loader.bin

wget --no-check-certificate  https://ci.betrusted.io/releases/v0.9.5/xous.img -O xous.img

wget --no-check-certificate  https://ci.betrusted.io/releases/v0.9.5/soc_csr.bin -O soc_csr.bin

wget --no-check-certificate  https://ci.betrusted.io/releases/v0.9.5/ec_fw.bin -O ec_fw.bin
wget --no-check-certificate  https://ci.betrusted.io/releases/v0.9.5/bt-ec.bin -O bt-ec.bin
wget --no-check-certificate  https://ci.betrusted.io/releases/v0.9.5/wfm_wf200_C0.sec -O wfm_wf200_C0.sec
wget --no-check-certificate  https://ci.betrusted.io/releases/v0.9.5/wf200_fw.bin -O wf200_fw.bin
