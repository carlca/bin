#!/bin/zsh

# pwd setup
mkdir ~/edk2-fix
cd edk2-fix

# download bz2
curl -LO https://gitlab.com/kraxel/qemu/-/raw/704f7cad5105246822686f65765ab92045f71a3b/pc-bios/edk2-aarch64-code.fd.bz2

# extract bz2
bzip2 -d edk2-aarch64-code.fd.bz20

# backup
cp /opt/homebrew/share/qemu/edk2-aarch64-code.fd ./edk2-aarch64-code.fd.old

# temporary manual patch of the edk2 fd file
cp ./edk2-aarch64-code.fd /opt/homebrew/share/qemu/edk2-aarch64-code.fd

# clean podman
podman machine stop
podman machine rm    # validate the prompt by Pressing 'y' + 'ENTER'

# reinit and and VM
podman machine init
podman machine start