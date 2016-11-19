provider "docker" {}

# Create a container
resource "docker_container" "agent" {
  image   = "${docker_image.tc.name}"
  name    = "teamcity-agent-${ count.index + 1 }"
  count   = 3
  command = ["/run-services.sh"]
  env     = ["SERVER_URL=http://${docker_container.server.ip_address}:8111"]
}

resource "docker_container" "server" {
  image    = "${docker_image.tc-server.latest}"
  name     = "teamcity-server"
  hostname = "teamcity"

  ports {
    internal = 8111
    external = 8111
  }
}

resource "docker_image" "tc" {
  name = "scboucher/packer-ansible-demo:0.1"
}

resource "docker_image" "tc-server" {
  name = "jetbrains/teamcity-server"
}
