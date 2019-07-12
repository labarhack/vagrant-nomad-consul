job "echo-server" {

  datacenters = [ "dc1" ]
  type = "service"

  group "sample" {

    task "echo-server" {

      driver = "docker"

      config {
        image = "hashicorp/http-echo"
        args = [
          "-text", "hello-world"
        ]
        port_map {
          http = 5678
        }
      }
      resources {
        cpu = 100
        memory = 64
        network {
          mbits = 10
          port "http" {}
        }
      }
      service {
        tags = ["echo-server"]
        port = "http"
        name = "echo-server"
        check {
          name     = "HTTP Check"
          type     = "http"
          protocol = "http"
          path = "/"
          interval = "10s"
          timeout  = "2s"
        }
      }
    }
  }
}
