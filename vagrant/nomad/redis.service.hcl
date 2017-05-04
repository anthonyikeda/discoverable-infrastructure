job "redis" {
  datacenters = ["west-aws"]

  group "storage" {
    count = 3

    task "redis" {
      driver = "docker"
      config {
        image = "redis"
      }

      resources {
        memory = 128
      }
    }
  }
}
