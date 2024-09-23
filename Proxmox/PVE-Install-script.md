#ZFS Pool importieren
zpool import -f <PoolName>

#ZFS Mirror mit unterschiedlichen groessen
zpool create -f -o ashift=12 local-SSD-Mirror mirror /dev/disk/by-id/... /dev/disk/by-id/...

#non subscription meldung
sed -Ezi.bak "s/(Ext.Msg.show\(\{\s+title: gettext\('No valid sub)/void\(\{ \/\/\1/g" /usr/share/javascript/proxmox-widget-toolkit/proxmoxlib.js && systemctl restart pveproxy.service

#kernal parameter berbeiten
nano /etc/default/grub
    Bei GRUB_CMDLINE_LINUX_DEFAULT --> intel_iommu=on iommu=pt
update-grub

#Kernel modules hinzufuegen
nano /etc/modules
    -->  
vfio
vfio_iommu_type1
vfio_pci

update-initramfs -u -k all
lsmod | grep vfio

#install openvswitch
apt install openvswitch-switch ceph-mgr-dashboard


mkfs.btrfs -m raid1 -d raid1 -L My-Storage /dev/sdb1 /dev/sdc1


ZFS Pool auf node Ebene, Pool auf Center Ebene loeschen und Directory mit /<ZFS-Pool-Name>

https://web.archive.org/web/20220127115304/https://www.sebastiankargl.com/how-to-setup-kemp-loadmaster-on-proxmox/

cd /mnt/pve/ISOs/template/iso/

qm importovf 2550 LoadMaster-VLM-7.2.59.2.22338.RELEASE-VMware-OVF-FREE.ovf local-SSD-Pool
