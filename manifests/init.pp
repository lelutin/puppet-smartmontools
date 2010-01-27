# This module is distributed under the GNU Affero General Public License:
# 
# Smartmontools module for puppet
# Copyright (C) 2010 Sarava Group
# 
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
# 
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

class smartmontools {
  package { "smartmontools":
    ensure => installed,
  }

  #$devices = $smartdevices ? {
  #  ''      => [ '/dev/hda', '/dev/hdb' ]
  #  default => $smart_devices;
  #}

  #file { "/etc/smartmontools":
  #  ensure => 'directory',
  #  owner  => 'root',
  #  group  => 'root',
  #  mode   =>  0755,
  #}

  #file { "/etc/smartd.conf":
  #  ensure  => present,
  #  owner   => root,
  #  group   => root,
  #  mode    => 0644,
  #  notify  => Service["smartmontools"],
  #  require => File["/etc/smartmontools"],
  #  content => template('smartmontools/smartmontools.conf.erb'),
  #}

  file { "/etc/default/smartmontools": 
    ensure  => present,
    owner   => root,
    group   => root,
    mode    => 0644,
    notify  => Service["smartd"],
    source  => "puppet://$server/modules/smartmontools/default/smartmontools",
  }

  service { "smartd":
    enable     => true,
    hasrestart => true,
    ensure     => running,
    require    => [ File["/etc/default/smartmontools"], Package["smartmontools"] ],
  }
}
