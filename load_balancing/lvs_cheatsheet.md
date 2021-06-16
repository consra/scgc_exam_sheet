# Linux Virtual Server (LVS)  

RS: Real Server  
VS: Virtual Server (director)  
DR: Direct Routing  
TUN: Tunneling  

```bash

# These commands are issued on vm1, which is the director (Virtual Server).
# This server is the entry point that does the actual balancing.

# Add the 10.0.0.1/24 address on the ens3:1 subinterface.
ip addr add dev ens3 10.0.0.1/24 label ens3:1

# Configure the HTTP service as a virtual service: specify
# the virtual server address and port and the transport
# protocol used (TCP, in our case). The -A flag means add
# service, -t flag means tcp service address.
ipvsadm -A -t 10.0.0.1:80

# Add the real servers. The -g flag means LVS-DR, the -a 
# means add server, -r real server address, -t is tcp service 
# address.
ipvsadm -a -t 10.0.0.1:80 -r 10.0.0.20:80 -g
ipvsadm -a -t 10.0.0.1:80 -r 10.0.0.30:80 -g

#########################################################################################################
# These commands are issued on vm2 and vm3 which are the Real Servers. This
# is where the requests are redirected and where they will be processed.

# “Convince” the RS's to answer to requests destined for
# the VS address. Configure an iptables rule that makes it so
# the RS accepts the packets even if the VS address was not
# configured on any interface.
iptables -t nat -A PREROUTING -d 10.0.0.1 -j REDIRECT # Issue this command on vm2, which is a real server.
iptables -t nat -A PREROUTING -d 10.0.0.1 -j REDIRECT # Issue this command on vm3, which is a real server.

#########################################################################################################

# Activate the round-robin scheduler and configure a maximum of 4 simultaneous connections for each RS.
# The -E flags means the service is going to be edited. The -e flag means the real server is going to
# be edited.
ipvsadm -E -t 10.0.0.1:80 -s rr
ipvsadm -e -t 10.0.0.1:80 -r 10.0.0.20:80 -x 4
ipvsadm -e -t 10.0.0.1:80 -r 10.0.0.30:80 -x 4

#### Commands for checking the configuration.

# Start a capture on the br0 interface on the client machine (host machine for the KVMs, do not issue
on VS or RSs).
sudo tcpdump -i br0 -e

# Check VS state. Issue this on vm1, which is the VS. The -c flags is used to show info about the
# connections managed by the VS.
ipvsadm -l -c 

#### Commands for removal.

# Delete the service on vm1, which is the VS.
ipvsadm -D -t 10.0.0.1:80

#########################################################################################################
# Delete the iptables rules from vm2 and vm3 which are the RSs.
iptables -t nat -F
iptables -t nat -F
#########################################################################################################

```

