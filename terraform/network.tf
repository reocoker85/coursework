resource "yandex_vpc_network" "devops-network" {
  name = "devops-network"
}

resource "yandex_vpc_subnet" "subnet-a" {
  name           = "subnet-a"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.devops-network.id
  v4_cidr_blocks = ["192.168.0.0/28"]
  route_table_id = yandex_vpc_route_table.rt.id
}

resource "yandex_vpc_subnet" "subnet-b" {
  name           = "subnet-b"
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.devops-network.id
  v4_cidr_blocks = ["192.168.1.0/28"]
  route_table_id = yandex_vpc_route_table.rt.id
}

resource "yandex_vpc_subnet" "private-subnet" {
  name           = "privet-subnet"
  zone           = "ru-central1-d"
  network_id     = yandex_vpc_network.devops-network.id
  v4_cidr_blocks = ["192.168.2.0/24"]
  route_table_id = yandex_vpc_route_table.rt.id
}

resource "yandex_vpc_subnet" "public-subnet" {
  name           = "public-subnet"
  zone           = "ru-central1-d"
  network_id     = yandex_vpc_network.devops-network.id
  v4_cidr_blocks = ["192.168.3.0/24"]
}




#resource "yandex_vpc_gateway" "nat_gateway" {
#  name = "test-gateway"
#  shared_egress_gateway {}
#}

resource "yandex_vpc_route_table" "rt" {
  name       = "test-route-table"
  network_id = yandex_vpc_network.devops-network.id

  static_route {
    destination_prefix = "0.0.0.0/0"
    next_hop_address = yandex_compute_instance.vm-1.network_interface.0.ip_address
  }
}
