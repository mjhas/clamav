class clamav(
  $milter=false,
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
  if defined(Package['amavis']){
    user {'clamav':
      ensure  => present,
      gid     => 'clamav',
      groups  => ['amavis'],
      require => Package['clamav-daemon','amavis']
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
