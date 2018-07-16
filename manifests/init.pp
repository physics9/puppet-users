define users::virtual ($ensure, $uid, $gid, $email) {

include users::params
$homepath  = $users::params::homepath
$shell     = $users::params::shell

#make a group
group {$name:
  ensure            => $ensure,
  gid               => $gid
}

#make a user
user {$name:
  ensure            =>  $ensure,
  uid               =>  $uid,
  gid               =>  $gid,
  shell             =>  $shell,
  home              =>  "${homepath}/${name}",
  comment           =>  $email,
  managehome        =>  true,
  require           =>  Group[$name],
}

File { "${homepath}/${name}":
  ensure            =>  directory,
  owner             =>  $name,
  group             =>  $name,
  mode              =>  '0700',
  require           =>  [ User[$name], Group[$name] ],
}

file { "${homepath}/${name}/.ssh":
  ensure            =>  directory,
  owner             =>  $name,
  group             =>  $name,
  mode              =>  '0700',
  require           =>  [ User[$name], Group[$name] ],
}


file { "${homepath}/${name}/.ssh/authorized_keys":
  ensure            =>  present,
  source            =>  "puppet:///modules/users/$name",
  owner             =>  $name,
  group             =>  $name,
  mode              =>  '0640',
  require           =>  [ User[$name], Group[$name] ],
}
}
