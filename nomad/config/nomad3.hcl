consul {
  address = "172.20.20.11:8500"
  client_service_name = "nomad-client"
  server_service_name = "nomad-server-1"
  checks_use_advertise = true
}

client {
  enabled = true
}

advertise {
  http = "172.20.20.17"
  rpc  = "172.20.20.17"
  serf = "172.20.20.17"
}

#addresses {
#  http = "172.20.20.17"
#  rpc  = "172.20.20.17"
#  serf = "172.20.20.17"
#}

bind_addr = "0.0.0.0"
data_dir = "/tmp/nomad"
datacenter = "west-aws"

ports {
  http = 4666
  rpc = 4667
  serf = 4668
}
