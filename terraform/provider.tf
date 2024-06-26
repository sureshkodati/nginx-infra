# Configure Google Cloud Provider
provider "google" {
  project = var.project_id
  region  = var.my_region
  zone    = var.my_zone
}

# Backend configuration (replace with your bucket name and region)
terraform {
  backend "gcs" {
    bucket = "backend-dev-project-426703"
  }
}

