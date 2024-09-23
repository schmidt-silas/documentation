1. Download the ISO using the GUI (tested on https://cloud-images.ubuntu.com/)
1. Create the VM via CLI
```
qm create 5000 --memory 2048 --core 2 --name ubuntu-cloud --net0 virtio,bridge=vmbr0
cd /mnt/pve/ISOs/template/iso/
qm importdisk 5000 noble-server-cloudimg-amd64.img local-btrfs
qm set 5000 --scsihw virtio-scsi-pci --scsi0 local-btrfs:5000/vm-5000-disk-0.raw
qm set 5000 --ide2 local-btrfs:cloudinit
qm set 5000 --boot c --bootdisk scsi0
qm set 5000 --serial0 socket --vga serial0
```
3. Expand the VM disk size to a suitable size (suggested 10 GB)
4. Create the Cloud-Init template 
5. Deploy new VMs by cloning the template (full clone)