resource "yandex_vpc_security_group" "public-sg" {
  name        = "public-sg"
  description = "Security group for bastion"
  network_id  = yandex_vpc_network.devops-network.id

  ingress {
    protocol           = "TCP"
    description        = "SSH from public IP addresses"
    port               = 22
    v4_cidr_blocks     = ["0.0.0.0/0"]
  }

 ingress {
    protocol           = "TCP"
    description        = "HTTP"
    port               = 80
    v4_cidr_blocks     = ["192.168.0.0/22"]
  }

  ingress {
    protocol           = "TCP"
    description        = "HTTPS"
    port               = 443
    v4_cidr_blocks     = ["192.168.0.0/22"]
  }

  ingress {
    protocol           = "ICMP"
    description        = "ICMP"
    v4_cidr_blocks     = ["0.0.0.0/0"]
  }

  egress {
    protocol           = "ANY"
    description        = "Allow any outgoing traffic"
    v4_cidr_blocks     = ["0.0.0.0/0"]
  }
}

resource "yandex_vpc_security_group" "private-sg" {
  name        = "private-sg"
  description = "Security group for privet group"
  network_id  = yandex_vpc_network.devops-network.id

 ingress {
    protocol       = "ANY"
    v4_cidr_blocks = ["192.168.0.0/22"]
   }
  
 egress {
    protocol       = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "yandex_vpc_security_group" "alb-sg" {  
  name        = "alb-sg"
  description =  "Security group for application loadbalancer" 
  network_id  = yandex_vpc_network.devops-network.id 
  
  ingress {
    protocol = "ANY" 
    description = "Health checks"
    v4_cidr_blocks = ["0.0.0.0/0"]
    predefined_target = "loadbalancer_healthchecks"
  }

  ingress {
    protocol = "TCP" 
    description = "allow HTTP connections from internet" 
    v4_cidr_blocks = ["0.0.0.0/0"]
    port = 80
  }

  ingress {
    protocol = "ICMP" 
    description = "allow ping" 
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol = "ANY" 
    description = "allow any outgoing connection" 
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "yandex_vpc_security_group" "kibana-sg" {
  name        = "kibana-sg"
  description = "Security group for kinaba"
  network_id  = yandex_vpc_network.devops-network.id

  ingress {
    protocol = "TCP" 
    description = "allow kibana connections from internet" 
    v4_cidr_blocks = ["0.0.0.0/0"]
    port = 5601
  }

  ingress {
    protocol = "ICMP" 
    description = "allow ping" 
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
 
  egress {
    protocol = "ANY" 
    description = "allow any outgoing connection" 
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "yandex_vpc_security_group" "zabbix-sg" {
  name        = "zabbix-sg"
  description = "Security group for zabbix-web"
  network_id  = yandex_vpc_network.devops-network.id

  ingress {
    protocol = "TCP" 
    description = "allow zabbix connections from internet" 
    v4_cidr_blocks = ["0.0.0.0/0"]
    port = 80
  }

  ingress {
    protocol = "ICMP" 
    description = "allow ping" 
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol = "ANY" 
    description = "allow any outgoing connection" 
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

