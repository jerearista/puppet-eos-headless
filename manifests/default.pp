notify { 'Made it!': }

node /^veos\d+/ {
  notify { 'Node: veos*': }
  #class { 'local::motd': }
  #hiera_include('classes')
}


node default {
  notify { 'Node: default': }
}
