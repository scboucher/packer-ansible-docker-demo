provider "docker" {}

# Create  containers
resource "docker_container" "agent" {
  image   = "${docker_image.teamcity-agent.name}"
  name    = "teamcity-agent-${ count.index + 1 }"
  count   = "${var.docker-container-count}"
  command = ["/run-services.sh"]
  env     = ["SERVER_URL=http://${docker_container.server.ip_address}:8111"]
}

resource "docker_container" "server" {
  image    = "${docker_image.teamcity-server.latest}"
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
resource "docker_image" "teamcity-agent" {
  name         = "jetbrains/teamcity-agent:10.0.3"
  keep_locally = true
}

resource "docker_image" "teamcity-server" {
  name         = "jetbrains/teamcity-server:10.0.3"
  keep_locally = true
}

resource "docker_image" "mysql" {
  name         = "mysql/mysql-server:5.7"
  keep_locally = true
}

# # Database Connecion settings
# provider "mysql" {
#   # endpoint = "${docker_container.db.ip_address}:3306"
#   endpoint = "localhost:3306"
#   username = "root"
#   password = "${var.db-password}"

#  depends_on = "docker_container.db"
# }

# Create a Database
resource "mysql_database" "teamcity" {
  # depends_on = "${docker_container.db}"
  name = "teamcity"
}

resource "mysql_user" "teamcity" {
  # depends_on = "${docker_container.db}"
  user     = "teamcity"
  host     = "%"
  password = "password"
}
