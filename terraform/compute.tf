data "yandex_compute_image" "ubuntu_image" {
  family = "ubuntu-2004-lts"
}

data "yandex_compute_image" "nat_instance_image" {
  family = "nat-instance-ubuntu-2204"
}



resource "yandex_compute_instance" "vm-1" {
  name        = "bastion"
  platform_id = "standard-v3"
  zone        = "ru-central1-d"

  resources {
    cores         = 2
    memory        = 2
    core_fraction = 20
  }
  scheduling_policy {
    preemptible = true
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.nat_instance_image.id
      size     = 8
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.public-subnet.id
    nat                = true
    security_group_ids = [yandex_vpc_security_group.public-sg.id]
  }

  metadata = {
    user-data = "${file("./meta.txt")}"
  }
}

resource "yandex_compute_instance" "vm-2" {
  name        = "elasticsearch"
  hostname    = "elasticsearch" 
  platform_id = "standard-v3" 
  zone        = "ru-central1-d"

  resources {
    cores  = 2
    memory = 4
    core_fraction = 20
  }
  scheduling_policy {
    preemptible = true
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu_image.id
      size     = 10 
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.private-subnet.id
    nat                = false
    security_group_ids = [yandex_vpc_security_group.private-sg.id]
  }
  
  metadata = {
    user-data = "${file("./meta.txt")}"
  }
}

resource "yandex_compute_instance" "vm-3" {
  name        = "kibana"
  hostname    = "kibana"
  platform_id = "standard-v3"
  zone        = "ru-central1-d"

  resources {
    cores  = 2
    memory = 2
    core_fraction = 20
  }
  scheduling_policy {
    preemptible = true
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu_image.id
      size     = 5
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.private-subnet.id
    nat                = true
    security_group_ids = [yandex_vpc_security_group.private-sg.id, yandex_vpc_security_group.kibana-sg.id]
  }

  metadata = {
    user-data = "${file("./meta.txt")}"
  }
}

resource "yandex_compute_instance" "vm-4" {
  name        = "zabbix-server"
  hostname    = "zabbix-server"
  platform_id = "standard-v3"
  zone        = "ru-central1-d"

  resources {
    cores  = 2
    memory = 2
    core_fraction = 20
  }
  scheduling_policy {
    preemptible = true
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu_image.id
      size     = 5
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.private-subnet.id
    nat                = false
    security_group_ids = [yandex_vpc_security_group.private-sg.id]
  }

  metadata = {
    user-data = "${file("./meta.txt")}"
  }
}

resource "yandex_compute_instance" "vm-5" {
  name        = "zabbix-web"
  hostname    = "zabbix-web"
  platform_id = "standard-v3"
  zone        = "ru-central1-d"

  resources {
    cores         = 2
    memory        = 2
    core_fraction = 20
  }
  scheduling_policy {
    preemptible = true
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu_image.id
      size     = 5
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.private-subnet.id
    nat                = true
    security_group_ids = [yandex_vpc_security_group.private-sg.id, yandex_vpc_security_group.zabbix-sg.id]
  }

  metadata = {
    user-data = "${file("./meta.txt")}"
  }
}
