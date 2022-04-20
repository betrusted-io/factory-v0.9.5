#!/bin/bash
set -e

read -p "Download $1 artifacts? (y/N) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    [[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1
fi

echo "Updating to $1 stabilized release"

wget --no-check-certificate  https://ci.betrusted.io/releases/$1/loader.bin -O loader.bin

wget --no-check-certificate  https://ci.betrusted.io/releases/$1/xous.img -O xous.img

wget --no-check-certificate  https://ci.betrusted.io/releases/$1/soc_csr.bin -O soc_csr.bin

wget --no-check-certificate  https://ci.betrusted.io/releases/$1/ec_fw.bin -O ec_fw.bin
wget --no-check-certificate  https://ci.betrusted.io/releases/$1/bt-ec.bin -O bt-ec.bin
wget --no-check-certificate  https://ci.betrusted.io/releases/$1/wfm_wf200_C0.sec -O wfm_wf200_C0.sec
wget --no-check-certificate  https://ci.betrusted.io/releases/$1/wf200_fw.bin -O wf200_fw.bin

echo $1 > VERSION
