resource "yandex_compute_instance" "web_server" {
  count = 2

  name = "web-server-${count.index}"
  platform_id = "standard-v3"
  zone = "ru-central1-a"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd82bte7854avbpitj82"  # Debian 11
      size     = 10
      type     = "network-hdd"
    }
  }
network_interface {
    subnet_id = yandex_vpc_subnet.subnet-1.id
    nat       = true
  }

  metadata = {
    ssh-keys = "debian:${file("${path.module}/keys/id_rsa.pub")}"  # исправлено>
  }
}

resource "null_resource" "provision_nginx" {
  count = 2

  triggers = {
    instance_id = yandex_compute_instance.web_server[count.index].id
  }

  depends_on = [yandex_compute_instance.web_server]

  connection {
type        = "ssh"
    host        = yandex_compute_instance.web_server[count.index].network_inter>
    user        = "debian"  # исправлено: ubuntu → debian
    private_key = file("${path.module}/keys/id_rsa")
    timeout     = "5m"  # добавлен таймаут 5 минут
  }

  provisioner "local-exec" {
    command = "sleep 60"  # задержка 60 секунд перед подключением
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt update",
      "sudo apt install -y nginx",
      "sudo systemctl start nginx",
      "sudo systemctl enable nginx"
    ]
  }
}
