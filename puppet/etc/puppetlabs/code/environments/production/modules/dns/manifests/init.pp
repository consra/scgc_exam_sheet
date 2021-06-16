class dns {
	package { 'bind':
		name => 'bind',
		ensure => 'installed',
		provider => yum,
	}
	package { 'bind-utils':
		name => 'bind-utils',
		ensure => 'installed',
		provider => yum,
	}
	file { '/etc/named.conf':
		path => '/etc/named.conf',
		require => [Package['bind'], Package['bind-utils']],
		mode => '0644',
		ensure => present,
		content => file('dns/x-men.named.conf.local'),
	}
	file { '/var/named/db.x-men.local':
		path => '/var/named/db.x-men.local',
		require => [Package['bind'], Package['bind-utils']],
		mode => '0644',
		ensure => present,
		content => file('dns/db.x-men.local'),
	}
	exec { 'firewall port 53 tcp':
		command => 'firewall-cmd --permanent --add-port=53/tcp && firewall-cmd --reload',
		path => '/usr/local/bin/:/bin',
	}
	exec { 'firewall port 53 udp':
		command => 'firewall-cmd --permanent --add-port=53/udp && firewall-cmd --reload',
		path => '/usr/local/bin/:/bin',
	} 
	service { 'named':
		enable => true,
		ensure => running,
		require => [Exec['firewall port 53 tcp'], Exec['firewall port 53 udp']],
		subscribe => [File['/var/named/db.x-men.local'], File['/etc/named.conf']],
	}
}

