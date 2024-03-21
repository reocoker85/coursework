resource "yandex_mdb_postgresql_database" "zabbix_db" {
  cluster_id = yandex_mdb_postgresql_cluster.netology_cluster.id
  name       = "zabbix_db"
  owner      = yandex_mdb_postgresql_user.admin.name
  lc_collate = "en_US.UTF-8"
  lc_type    = "en_US.UTF-8"
  extension {
    name = "uuid-ossp"
  }
  extension {
    name = "xml2"
  }
}

resource "yandex_mdb_postgresql_user" "admin" {
  cluster_id = yandex_mdb_postgresql_cluster.netology_cluster.id
  name       = "reo"
  password   = "reocoker"
}

resource "yandex_mdb_postgresql_cluster" "netology_cluster" {
  name        = "cluster1"
  environment = "PRESTABLE"
  network_id  = yandex_vpc_network.devops-network.id
  security_group_ids = [yandex_vpc_security_group.private-sg.id]

  config {
    version      = 14
    autofailover = true
    resources {
      resource_preset_id = "s2.micro"
      disk_type_id       = "network-ssd"
      disk_size          = 16
    }
  }

  host {
    name      = "host_name_a"
    zone      = "ru-central1-d"
    subnet_id = yandex_vpc_subnet.private-subnet.id
  }

  host {
    name      = "host_name_b"
    zone      = "ru-central1-d"
    subnet_id = yandex_vpc_subnet.private-subnet.id
  }

}



