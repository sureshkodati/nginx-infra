resource "google_service_account" "nginx_sa" {
  account_id   = "nginx-sa"
  display_name = "Service Account"
}

resource "google_project_iam_member" "nginx_sa_member" {
  for_each = var.service_account_roles
  project  = var.project_id
  member   = "serviceAccount:${google_service_account.nginx_sa.email}"
  role     = each.key

}