# Resource to create a Windows VM instance
resource "google_compute_instance" "windows_server" {
  name         = var.vm_name
  machine_type = var.machine_type # Adjust as needed

  boot_disk {
    initialize_params {
      image = var.linux_server_image
    }
  }

  network_interface {
    network    = google_compute_network.vpc_network.name
    subnetwork = google_compute_subnetwork.subnet.name
    access_config {
      # Ephemeral public IP for internet access
      network_tier = "PREMIUM"
    }
  }

  # Add startup script to configure IIS (replace with actual script)
  metadata_startup_script = <<EOF
  # Script to install IIS (replace with actual commands)
  echo "Testing"
  # ...
  EOF
}

#Output the VM's external IP address (if assigned)
output "vm_ip" {
  #value = google_compute_instance.vm_instance.network_interface.0.access_config.0.external_nat_ip
  value = google_compute_instance.windows_server.network_interface.0.network_ip
}
