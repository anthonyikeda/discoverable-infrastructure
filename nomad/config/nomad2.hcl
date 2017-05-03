consul {
  address = "172.20.20.10:8500"
  client_service_name = "nomad-client"
}

client {
  enabled = true
}

advertise {
  http = "172.20.20.16"
  rpc  = "172.20.20.16"
  serf = "172.20.20.16"
}

addresses {
  http = "172.20.20.16"
  rpc  = "172.20.20.16"
  serf = "172.20.20.16"
}

bind_addr = "0.0.0.0"
data_dir = "/tmp/nomad"
datacenter = "west-aws"

ports {
  http = 4656
  rpc = 4657
  serf = 4658
}
