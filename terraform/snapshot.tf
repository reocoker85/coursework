
resource "yandex_compute_snapshot_schedule" "snapshot-full" {
  name = "snapshot-full"

  schedule_policy {
    expression = "0 0 * * *"
  }

  snapshot_count = 7

  snapshot_spec {
      description = "Daily snapshot"
 }

  retention_period = "168h"

  disk_ids = [
    yandex_compute_instance.vm-1.boot_disk.0.disk_id, 
    yandex_compute_instance.vm-2.boot_disk.0.disk_id, 
    yandex_compute_instance.vm-3.boot_disk.0.disk_id, 
    yandex_compute_instance.vm-4.boot_disk.0.disk_id, 
    yandex_compute_instance.vm-5.boot_disk.0.disk_id,
  ]
             
}
