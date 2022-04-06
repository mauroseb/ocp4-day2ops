#!/bin/bash

VERSION=4.10
URL=api-int.t1.lab.local
WORKDIR=./ocp/

# worker number ( hostname will be ice-ocp4-worker-${I} )
I=2

echo "q" | openssl s_client -connect $URL:22623  -showcerts | awk '/-----BEGIN CERTIFICATE-----/,/-----END CERTIFICATE-----/' | base64 --wrap=0 | tee ./api-int.base64 && \
sed --regexp-extended --in-place=.backup "s%base64,[a-zA-Z0-9+\/=]*%base64,$(cat ./api-int.base64)%" ${WORKDIR}/worker.ign

sudo virt-install --name ice-ocp4-worker-${I} \
  --vcpus 4 --ram 16384 --cpu host-passthrough,+vmx \
  --disk size=40,pool=fast --disk size=50,pool=fast \
  --os-type linux --os-variant rhel8.4 \
  --noautoconsole --vnc \
  --network network=ocp4_net --noreboot --noautoconsole \
  --location http://192.168.133.1:8080/rhcos/${VERSION}/ \
  --extra-args "nomodeset rd.neednet=1 coreos.inst=yes coreos.inst.install_dev=vda coreos.inst.image_url=http://192.168.133.1:8080/rhcos/${VERSION}/bios.raw.gz coreos.inst.ignition_url=http://192.168.133.1:8080/ocp/worker.ign coreos.live.rootfs_url=http://192.168.133.1:8080/rhcos/"${VERSION}"/rootfs.img coreos.inst.insecure ip=192.168.133.7"$(( ${I} + 1))"::192.168.133.1:255.255.255.0:ice-ocp4-worker-"${I}".lab.local:enp1s0:none nameserver=192.168.133.9"
