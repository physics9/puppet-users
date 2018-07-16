define users::virtual () {
include users::params
$homepath  = $users::params::homepath
$shell     = $users::params::shell

#create the user
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

# Ensure the home directory exists with the right permissions
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

# Add user's SSH key
ssh_authorized_key { $email:
ensure           => present,
name             => $name,
user             => $name,
type             => $sshkeytype,
key              => $sshkey,
}

file { "${homepath}/${name}/.ssh/authorized_keys":
ensure            =>  present,
content           =>  'puppet:///modules/users/ssh_keys,
owner             =>  $name,
group             =>  $admin,
mode              =>  '0640',
require           =>  [ User[$name], Group[$admin] ],
}
}




