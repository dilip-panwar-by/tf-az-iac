resource "random_password" "vmpassword" {
  length  = var.length
  special = var.special
}