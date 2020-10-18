provider "google" {
 credentials = file(var.terraform_keyfile)
 project     = "${var.project_id}"
 region      = "${var.region}"
}

resource "google_compute_firewall" "default" {
 name    = "mediawiki-firewall"
 network = "default"

 allow {
   protocol = "tcp"
   ports    = ["80" ,"443"]
 }

 source_ranges = ["0.0.0.0/0"]
 source_tags = ["web"]

}

resource "google_compute_instance" "mediawiki_instance" {
    name         = "mediawiki"
    machine_type = "f1-micro"
    zone         = "${var.zone}"

    boot_disk {
        initialize_params{
            image = "$var.image_name"
        }
    }

    metadata = {
        ssh-keys = "${var.ssh_username}:${file(var.ssh_pub_keyfile)}"
    }

    network_interface {
        network = "default"
        access_config {
        }
    }
}

output "ip" {
 value = "${google_compute_instance.mediawiki_instance.network_interface.0.access_config.0.nat_ip}"
}
