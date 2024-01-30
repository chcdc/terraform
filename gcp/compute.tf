resource "google_compute_instance" "this" {
  name         = var.machine
  machine_type = var.machine_type
  zone         = var.region

  boot_disk {
    initialize_params {
      image = var.image
      size  = var.disk_size_gb
    }
  }

  network_interface {
    network = google_compute_network.this.name

    access_config {}
  }
}

resource "google_compute_network" "this" {
  name                    = "network"
  auto_create_subnetworks = true
}

resource "google_compute_subnetwork" "this" {
  name          = "subnetwork"
  ip_cidr_range = "10.0.0.0/24"
  network       = google_compute_network.this.self_link
}

resource "google_compute_firewall" "allow_https" {
  name    = "allow-https"
  network = google_compute_network.this.name

  allow {
    protocol = "tcp"
    ports    = ["443"]
  }

  source_ranges = ["0.0.0.0/0"]
}

