class users::example {
users::virtual { 'example':
ensure            => present,
uid               => 100x,
email             => 'example@gmail.com',
sshkeytype        => 'ssh-rsa',
sshkey            =>
' Here input the users ssh-key'
}
}
