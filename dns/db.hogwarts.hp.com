; Check if file is valid with named-checkzone hogwarts.hp.com /etc/bind/db.hogwarts.hp.com

$TTL    604800
@       IN      SOA     hogwarts.hp.com. root.hogwarts.hp.com. (
                              2         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL

; NS records
@       IN      NS      ns1.hogwarts.hp.com.
@       IN      NS      ns2.hogwarts.hp.com.

; A records
ns1             IN      A       192.168.1.200
ns2             IN      A       192.168.1.201
mail1		        IN	    A	      192.168.1.202
mail2		        IN	    A	      192.168.1.203

; MX records
hogwarts.hp.com.        IN      MX      20     mail1.hogwarts.hp.com.
hogwarts.hp.com.        IN      MX      10     mail2.hogwarts.hp.com.

; CNAME records
cname1        IN      CNAME   sub1.hogwarts.hp.com.
cname2        IN      CNAME   sub2.hogwarts.hp.com.
