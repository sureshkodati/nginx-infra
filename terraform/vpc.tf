# VPC Network
resource "google_compute_network" "vpc_network" {
  name                    = var.my_vpc
  auto_create_subnetworks = false
}

# Subnet with Regional IP 
resource "google_compute_subnetwork" "subnet" {
  name          = var.my_subnet
  region        = var.my_region
  ip_cidr_range = var.cidr_range
  network       = google_compute_network.vpc_network.self_link
}

# Firewall Rule for allowing SSH & HTTP 
resource "google_compute_firewall" "ingress_rule" {
  name    = "ingress-rule"
  network = google_compute_network.vpc_network.self_link

  allow {
    protocol = "tcp"
    ports    = var.allowed_ports
  }

  source_ranges = ["0.0.0.0/0"] # Allow SSH from anywhere (adjust for security)
}

resource "google_compute_firewall" "egress_rule" {
  name    = "egress-rule"
  network = google_compute_network.vpc_network.self_link

  allow {
      ports    = []
      protocol = "all"
  }
  source_ranges = ["0.0.0.0/0"] # Allow SSH from anywhere (adjust for security)
}