# Host
wget (https://www.nvidia.com/en-us/drivers/unix/)
chmod +x NVIDIA-Linux-x86_64-*
./NVIDIA-Linux-x86_64-* --dkms

ls -l /dev/nvidia*
nano /etc/pve/lxc/XXX.conf

## Change nubers
lxc.cgroup2.devices.allow: c 195:* rwm # Die 195 anpassen
lxc.cgroup2.devices.allow: c 511:* rwm # Die 511 anpassen
lxc.mount.entry: /dev/nvidia0 dev/nvidia0 none bind,optional,create=file
lxc.mount.entry: /dev/nvidiactl dev/nvidiactl none bind,optional,create=file
lxc.mount.entry: /dev/nvidia-uvm dev/nvidia-uvm none bind,optional,create=file
lxc.mount.entry: /dev/nvidia-modeset dev/nvidia-modeset none bind,optional,create=file
lxc.mount.entry: /dev/nvidia-uvm-tools dev/nvidia-uvm-tools none bind,optional,create=file

# LXC
apt install build-essential lswh sudo curl -y
wget (https://www.nvidia.com/en-us/drivers/unix/)
chmod +x NVIDIA-Linux-x86_64-*
./NVIDIA-Linux-x86_64-* --no-kernel-modules 

## Container-Runtime
curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg \
  && curl -s -L https://nvidia.github.io/libnvidia-container/stable/deb/nvidia-container-toolkit.list | \
    sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | \
    sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list
sed -i -e '/experimental/ s/^#//g' /etc/apt/sources.list.d/nvidia-container-toolkit.list
sudo apt-get update
sudo apt-get install -y nvidia-container-toolkit

## CUDA Toolkit
wget https://developer.download.nvidia.com/compute/cuda/repos/debian12/x86_64/cuda-keyring_1.1-1_all.deb
sudo dpkg -i cuda-keyring_1.1-1_all.deb
sudo add-apt-repository contrib
sudo apt-get update
sudo apt-get -y install cuda-toolkit-12-6
