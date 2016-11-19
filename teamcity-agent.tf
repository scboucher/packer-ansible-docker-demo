provider "docker" {}

# Create  containers
resource "docker_container" "agent" {
  image   = "${docker_image.tc.name}"
  name    = "teamcity-agent-${ count.index + 1 }"
  count   = "${var.docker-container-count}"
  command = ["/run-services.sh"]
  env     = ["SERVER_URL=http://${docker_container.server.ip_address}:8111"]
}

resource "docker_container" "server" {
  image    = "${docker_image.tc-server.latest}"
  name     = "teamcity-server"
  hostname = "teamcity"

  # env =    ["TEAMCITY_SERVER_MEM_OPTS='-Xmx1g -XX:MaxPermSize=270m -XX:ReservedCodeCacheSize=350m'"] 

  ports {
    internal = 8111
    external = 8111
  }
}

resource "docker_container" "db" {
  image = "${docker_image.mysql.name}"
  name  = "teamcity-db"
  env   = ["MYSQL_ROOT_PASSWORD=${var.db-password}"]

  ports {
    internal = 3306
    external = 3306
  }
}

# List of Images used
resource "docker_image" "tc" {
  name         = "jetbrains/teamcity-agent:10.0.3"
  keep_locally = true
}

resource "docker_image" "tc-server" {
  name         = "jetbrains/teamcity-server:10.0.3"
  keep_locally = true
}

resource "docker_image" "mysql" {
  name         = "mysql/mysql-server:5.7"
  keep_locally = true
}

# Database Connecion settings
provider "mysql" {
  endpoint = "localhost:3306"
  username = "root"
  password = "${var.db-password}"
}

# Create a Database
resource "mysql_database" "teamcity" {

  name = "teamcity"
}

resource "mysql_user" "teamcity" {
  user     = "teamcity"
  host     = "%"
  password = "password"
}
