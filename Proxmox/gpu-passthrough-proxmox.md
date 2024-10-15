# Host
wget (https://www.nvidia.com/en-us/drivers/unix/)
chmod +x NVIDIA-Linux-x86_64-*
./NVIDIA-Linux-x86_64-* --dkms

ls -l /dev/nvidia*
nano /etc/pve/lxc/XXX.conf

## Change nubers
lxc.cgroup2.devices.allow: c 195:* rwm
lxc.cgroup2.devices.allow: c 511:* rwm
lxc.mount.entry: /dev/nvidia0 dev/nvidia0 none bind,optional,create=file
lxc.mount.entry: /dev/nvidiactl dev/nvidiactl none bind,optional,create=file
lxc.mount.entry: /dev/nvidia-uvm dev/nvidia-uvm none bind,optional,create=file
lxc.mount.entry: /dev/nvidia-modeset dev/nvidia-modeset none bind,optional,create=file
lxc.mount.entry: /dev/nvidia-uvm-tools dev/nvidia-uvm-tools none bind,optional,create=file

# LXC
apt install build-essential -y
wget (https://www.nvidia.com/en-us/drivers/unix/)
chmod +x NVIDIA-Linux-x86_64-*
./NVIDIA-Linux-x86_64-* --no-kernel-modules 
