data "template_file" "inventory" {
    template = "${file("hosts")}"

    vars = {
        bastion_ip           = "${yandex_compute_instance.vm-1.network_interface.0.nat_ip_address}"
        web_1_ip             = "${yandex_compute_instance_group.ig-web-server.instances.0.network_interface.0.ip_address}"
        web_2_ip             = "${yandex_compute_instance_group.ig-web-server.instances.1.network_interface.0.ip_address}"
        elasticsearch_ip     = "${yandex_compute_instance.vm-2.network_interface.0.ip_address}"
        kibana_ip            = "${yandex_compute_instance.vm-3.network_interface.0.ip_address}"
        zabbix_server_ip     = "${yandex_compute_instance.vm-4.network_interface.0.ip_address}"
        zabbix_frontend_ip   = "${yandex_compute_instance.vm-5.network_interface.0.ip_address}"
        kibana_ip_e          = "${yandex_compute_instance.vm-3.network_interface.0.nat_ip_address}"
        zabbix_frontend_ip_e = "${yandex_compute_instance.vm-5.network_interface.0.nat_ip_address}"
        db_fqdn              = "${yandex_mdb_postgresql_cluster.netology_cluster.host.0.fqdn}" 
    }
    
}

resource "null_resource" "update_inventory" {

    triggers = {
        template = "${data.template_file.inventory.rendered}"
    }

    provisioner "local-exec" {
        command = "echo '${data.template_file.inventory.rendered}' > ./host.ini"
    }
}

