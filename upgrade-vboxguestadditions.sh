#!/bin/sh

echo "[virtualbox] upgrade VBoxGuestAdditions"
apt-get -y -qq install linux-headers-4.4.0-177-generic dkms
curl -LO http://download.virtualbox.org/virtualbox/6.1.6/VBoxGuestAdditions_6.1.6.iso
mkdir -p /mnt/iso && mount -o loop /root/VBoxGuestAdditions_6.1.6.iso /mnt/iso
yes | sh /mnt/iso/VBoxLinuxAdditions.run --nox11
umount /mnt/iso && rm /root/VBoxGuestAdditions_6.1.6.iso
