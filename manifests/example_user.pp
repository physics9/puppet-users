class users::example {
users::virtual { 'example':
ensure            => present,
uid               => 100x,
gid               => 100x,
email             => 'example@gmail.com',
}
}
