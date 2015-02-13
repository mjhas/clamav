class clamav(
  $milter=false,
  $amavis=true,
) {
  package {'clamav-daemon':
    ensure  => latest
  }
  package {'clamav-freshclam':
    ensure  => latest,
    require => Package['clamav-daemon'],
  }
  service {'clamav-daemon':
    ensure  => running,
    require => Package['clamav-daemon']
  }
  if $amavis {
    package { 'amavisd-new':
      ensure  => latest,
    }
    user {'clamav':
      ensure  => present,
      gid     => 'clamav',
      groups  => ['amavis'],
      require => Package['clamav-daemon','amavisd-new'],
      notify  => Service['clamav-daemon'],
    }
  }
  service {'clamav-freshclam':
    ensure  => running,
    require => Package['clamav-freshclam']
  }
  if $milter {
    package {'clamav-milter':
      ensure  => latest,
      require => Package['clamav-daemon'],
    }
    service {'clamav-milter':
      ensure  => running,
      require => Package['clamav-milter']
    }
  }
}
