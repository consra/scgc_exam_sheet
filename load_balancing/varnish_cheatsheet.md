# Varnish

- Port 8061 is the default listening port
- Port 8062 is the default adminstration port
- The Varnish configurations can be found at /etc/default/varnish and /etc/varnish/default.vcl

```bash

# Install varnish.
sudo apt-get update
sudo apt-get install gcc varnish
sudo service varnish restart

# Get varnish listening port.
netstat -tlpn | grep varnish

# Change varnish listening port to 80.
vim /etc/default/varnish

# It should look like this:
# DAEMON_OPTS="-a :80 \
#              -T localhost:6082 \
#              -f /etc/varnish/default.vcl \
#              -S /etc/varnish/secret \
#              -s malloc,256m"

# Change the backend server (the actual server processes the
# requests redirected by varnish).
vim /etc/varnish/default.vcl

# It should look like this:
# backend default {
#     .host = "elf.cs.pub.ro";
#     .port = "80";
# }

# Modify /lib/systemd/system/varnish.service as below to set the Varnish port on 80:
# ExecStart=/usr/sbin/varnishd -j unix,user=vcache -F -a :80 -T localhost:6082 -f /etc/varnish/default.vcl -S /etc/varnish/secret -s malloc,256m
vim /lib/systemd/system/varnish.service

# Restart Varnish service.
sudo systemctl daemon-reload
sudo service varnish restart

# Add backend hostname to /etc/hosts:
#   10.0.0.10   elf.cs.pub.ro.
sudo vim /etc/hosts
ping elf.cs.pub.ro

# Install httperf
sudo apt-get install httperf

# Evaluate connection 
httperf --server=elf.cs.pub.ro --wsess=2000,10,2 --rate 300 --timeout 5

# In order to have a comparison with a direct access
# on elf.cs.pub.ro, delete the line we added in /etc/hosts.
# Run again the httperf command. Notice the difference
# between parameters.

# Check varnish statistics.
varnishlog -I RxURL

# Other varnish show commands:
varnishlog
varnishstat
varnishhist

```
