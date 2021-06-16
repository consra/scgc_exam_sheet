### DNS Configuration Info

**Packages**:  
bind9   
bind9utils

For Debian-based distributions, bind will have the following configuration files:

**Main configuration file**:   
/etc/bind/named.conf.options  

**Zone names file**:  
/etc/bind/named.conf.local  

**Zone file**:  
/etc/bind/db.hogwarts.hp.com  

**Default zone file location**:    
/var/cache/bind/  

Commands for syntax checking, service restart and DNS checking:
```
named-checkconf /etc/bind/named.conf.options # syntax check
named-checkconf /etc/bind/named.conf.local   # syntax check
named-checkzone scgc.ro /etc/bind/db.hogwarts.hp.com # syntax check

# Restart service
service bind9 restart # Debian
systemctl restart named.service # CentOS

# Check DNS
host hogwarts.hp.com localhost
host -t ns hogwarts.hp.com localhost # Check NS entries
 
```
