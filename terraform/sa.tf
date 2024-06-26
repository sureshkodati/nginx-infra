resource "google_service_account" "windows_sa" {
  account_id   = "windows-sa"
  display_name = "Service Account"
}