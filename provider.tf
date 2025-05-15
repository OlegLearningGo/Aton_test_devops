terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 1.00"
}

provider "yandex" {
  zone                     = "ru-central1-a"
  folder_id                = "b1g380lk4saufkerrugj"
}