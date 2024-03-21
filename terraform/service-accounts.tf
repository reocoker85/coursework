resource "yandex_iam_service_account" "reo-coker" {
  name        = "reo-coker"
  description = "service account to manage IG"
}

resource "yandex_resourcemanager_folder_iam_member" "editor" {
  folder_id = var.folder_id
  role      = "editor"
  member    = "serviceAccount:${yandex_iam_service_account.reo-coker.id}"
  depends_on = [
    yandex_iam_service_account.reo-coker,
  ]

}
