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
  http = "172.20.20.18"
  rpc  = "172.20.20.18"
  serf = "172.20.20.18"
}

addresses {
  http = "172.20.20.18"
  rpc  = "172.20.20.18"
  serf = "172.20.20.18"
}

bind_addr = "0.0.0.0"
data_dir = "/tmp/nomad"
datacenter = "west-aws"

ports {
  http = 4676
  rpc = 4677
  serf = 4678
}
