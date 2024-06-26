# Resource to create a Windows VM instance
resource "google_compute_instance" "nginx_server" {
  name         = var.vm_name
  machine_type = var.machine_type # Adjust as needed
  service_account {
    email = google_service_account.nginx_sa.email
    scopes = ["cloud-platform"]
  }
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
  # Update package lists
  sudo apt update

  # Install Nginx
  sudo apt install -y nginx

  gsutil cp gs://backend-dev-project-426703/sites.tar
  gsutil cp gs://backend-dev-project-426703/default

  sudo mkdir  /var/www/html/site
  tar -xvf sites.tar 
  sudo touch /var/www/html/index.html
  cat << EOT >> "/var/www/html/index.html"
  <h1> Sites </h1>
  <h2> Infosys </h2>
  <h2> Wellsfargo </h2>
  <h2> Microsoft </h2>
EOT
  sudo cp Sites/* /var/www/html/site -r
  sudo chown -R www-data:www-data /var/www/html/site
  sudo rm /etc/nginx/sites-available/default
  sudo cp default /etc/nginx/sites-available/default

  sudo systemctl restart nginx
  # ...
  EOF
}

#Output the VM's external IP address (if assigned)
output "vm_ip" {
  #value = google_compute_instance.vm_instance.network_interface.0.access_config.0.external_nat_ip
  value = google_compute_instance.nginx_server.network_interface.0.network_ip
}
