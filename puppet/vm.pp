package { "dkms":
    ensure => latest,
}

package { "chromium-browser":
    ensure => latest,
}

package { "emacs":
    ensure => latest,
}

package { "firefox":
    ensure => latest,
}

package { "gcc":
    ensure => latest,
}

package { "gedit":
    ensure => latest,
}

package { "git":
    ensure => latest,
}

package { "make":
    ensure => latest,
}

package { "mercurial":
    ensure => latest,
}

package { "nano":
    ensure => latest,
}

package { "sqlite3":
    ensure => latest,
}

package { "subversion":
    ensure => latest,
}

package { "vim":
    ensure => latest,
}

# R stuff
package { "r-base":
    ensure => latest,
}

package { "r-base-dev":
    ensure => latest,
}

package { "r-cran-plyr":
    ensure => latest,
}

package { "r-cran-reshape2":
    ensure => latest,
}

package { "r-cran-ggplot2":
    ensure => latest,
}

# for RCurl
package { "libcurl4-gnutls-dev":
    ensure => latest,
}

# for XML
package { "libxml2-dev":
    ensure => latest,
}

package { "r-cran-xml":
    ensure => latest,
}

user { "swc":
    home => "/home/swc",
    ensure => present,
    shell => "/bin/bash",
    password => '$6$BVLnY8oD$oBFoqq2aiZDQU/XaiMZrcuHz7ynf0Fq7EDIDp8nmXweo44oLz1.Vis1GTHgUbyNC4./.LEfwVgQci.uDgpj.V/',
    managehome => true,
}

file { "user_info":
    path => "/home/swc/Desktop/user_info",
    ensure => file,
    mode => 0644,
    owner => "swc",
    require => User["swc"],
    content => "Username: swc
Password: swc
",
}

exec { "bashrc":
    command => "/bin/echo '\nexport PATH=/home/swc/anaconda/bin:\$PATH' >> /home/swc/.bashrc",
    require => User["swc"]
}

file { "gitconfig":
    path => "/etc/gitconfig",
    ensure => file,
    mode => 0644,
    content => "[core]
    editor = gedit
[color]
    ui = auto
",
}

# Anaconda installation
exec { "download_anaconda":
    command => "/usr/bin/wget -P /tmp http://09c8d0b2229f813c1b93-c95ac804525aac4b6dba79b00b39d1d3.r79.cf1.rackcdn.com/Anaconda-2.1.0-Linux-x86.sh",
    creates => "/tmp/Anaconda-2.1.0-Linux-x86.sh",
    timeout => 3600
}

exec { "install_anaconda":
    user => "swc",
    command => "/bin/bash /tmp/Anaconda-2.1.0-Linux-x86.sh -b -p /home/swc/anaconda",
    creates => "/home/swc/anaconda",
    require => [Exec["download_anaconda"], User["swc"]],
}
