# LXD Cheatsheet

```bash

# Install LXD
apt install snapd
snap install --channel=2.0/stable lxd
export PATH="$PATH:/snap/bin"

# Initialize LXD. Careful: specify the correct IP address.
# You can leave the default for the rest.
lxd init

# Show LXD bridge.
brctl show lxdbr0

# Check bridge IP address.
ip address show lxdbr0

# List all LXD containers using the same command from LXC (which
# is not from the LXC package, is from LXD package, no LXC containers
# will be shown).
lxc list

# List available container images from official repositories.
lxc remote list

# List all images from ubuntu with version 20.04:
lxc image list ubuntu: 20.04

# Launch container named lxd-ct from image ubuntu:f (f is an alias for a version).
lxc launch ubuntu:f lxd-ct
lxc launch images:alpine/3.11 lxd-ct # you can also do it this way

# Connect to lxd-ct container.
lxc exec lxd-ct -- sudo --login --user ubuntu

# Quit container shell: CTRL - D

# Stop lxd-ct container.
xc stop lxd-ct

