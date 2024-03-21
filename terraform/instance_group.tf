resource "yandex_compute_instance_group" "ig-web-server" {
  name                = "autoscaled-ig-web-server"
  service_account_id  = yandex_iam_service_account.reo-coker.id
  deletion_protection = false
  depends_on          = [yandex_resourcemanager_folder_iam_member.editor]

    instance_template {
      platform_id = "standard-v3"
      resources {
        memory = 2
        cores  = 2
      }

      scheduling_policy {
        preemptible = true
      }

    boot_disk {
      mode = "READ_WRITE"
      initialize_params {
        image_id = data.yandex_compute_image.ubuntu_image.id
        size     = 5
      }
    }

    network_interface {
      network_id         = yandex_vpc_network.devops-network.id
      subnet_ids         = [yandex_vpc_subnet.subnet-a.id, yandex_vpc_subnet.subnet-b.id]
      security_group_ids = [yandex_vpc_security_group.private-sg.id]
    }

    metadata = {
      user-data = "${file("./meta.txt")}"
    }
  }

  scale_policy {
    auto_scale {
      initial_size           = 2
      measurement_duration   = 60
      cpu_utilization_target = 75
      min_zone_size          = 1
      max_size               = 3
      warmup_duration        = 60
      stabilization_duration = 120
    }
  }

  allocation_policy {
    zones = ["ru-central1-a",  "ru-central1-b"]
  }

  deploy_policy {
    max_unavailable = 1
    max_expansion   = 0
  }
  
  application_load_balancer {
    target_group_name        = "target-group"
    target_group_description = "load balancer target group"
  }  
}

