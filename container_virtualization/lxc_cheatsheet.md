# Container virtualization cheatsheet

```bash
# Check if the kernel supports LXC.
lxc-checkconfig

# Check if cgroup filesystem is mounted.
mount

# Create a new container named ct1 using the alpine template.
lxc-create -n ct1 -t alpine

# List LXC containers.
lxc-ls

# Inspect the configuration of the ct1 container.
cat /var/lib/lxc/ct1/config

# Start ct1 container in foreground mode using -F flag. You will
# attach to it using a terminal.
lxc-start -n ct1 -F # log in with root user, no password needed.

# Start ct1 container in background mode using -d (daemon).
lxc-start -n ct1 -d

# View state and PID of the container.
lxc-info -n ct1

# Attach to background container.
lxc-console -n ct1

# Exit container using: CTRL+A, Q.

```

LXC containers have their configuration stored at:
```
cat /var/lib/lxc/<container-name>/config
```

LXC containers have their filesystem stored in the host machine under the following path:
```
/var/lib/lxc/<container-name>/rootfs/
```
You can exhange files between host and container using this path.
