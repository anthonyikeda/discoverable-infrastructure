consul {
  address = "172.20.20.10:8500"
  client_service_name = "nomad-server-1"
}

server {
  enabled = true
  bootstrap_expect=3
}

advertise {
  http = "172.20.20.15"
  rpc  = "172.20.20.15"
  serf = "172.20.20.15"
}

addresses {
  http = "0.0.0.0"
  rpc  = "172.20.20.15"
  serf = "172.20.20.15"
}

bind_addr = "0.0.0.0"
data_dir = "/tmp/nomad"
datacenter = "west-aws"

ports {
  http = 4646
  rpc = 4647
  serf = 4648
}
