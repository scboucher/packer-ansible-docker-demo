provider "docker" {
}

# Create a container
resource "docker_container" "foo" {
    image = "${docker_image.tc.name}"
    name = "teamcity-agent"
    command = ["/run-services.sh"]
    env = ["SERVER_URL='http://localhost:8111'"]
}

resource "docker_image" "tc" {
    name = "scboucher/packer-ansible-demo:0.1"
}