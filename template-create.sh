root@gibson-virt-3:~# cat template.sh
#!/bin/bash
# Variables
vmid=1006
image=/path/to/image/on/hypervisor
name=name
user=user
password="password"

# Script
qm create $vmid --name $name --memory 2048 --cores 2 --net0 virtio,bridge=vmbr0
qm importdisk $vmid $image local-zfs
qm set $vmid --scsihw virtio-scsi-pci --scsi0 local-zfs:vm-$vmid-disk-0
qm set $vmid --ide2 local-zfs:cloudinit
qm set $vmid --boot c --bootdisk scsi0
qm set $vmid --serial0 socket --vga serial0
qm set $vmid --agent enabled=1
qm set $vmid --ipconfig0 ip=dhcp
qm set $vmid --ciuser $user
qm set $vmid --cipassword $password
qm set $vmid -cpu cputype=x86-64-v3

qm template $vmid

# qm commands
# [https://pve.proxmox.com/pve-docs/qm.1.html](https://pve.proxmox.com/pve-docs/qm.1.html)

# Cloud Init
# [https://pve.proxmox.com/wiki/Cloud-Init\_Support](https://pve.proxmox.com/wiki/Cloud-Init_Support)
