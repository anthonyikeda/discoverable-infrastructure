listener "tcp" {
  address = "0.0.0.0:8200"
  tls_disable = 1
}
storage "consul" {
  address = "consul1:8500"
  path    = "vault"
}
disable_mlock = true
