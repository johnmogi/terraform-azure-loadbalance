# there must be a way to hide these:
variable "admin_username" {
  type        = string
  default     = "adminuser"
  description = "frontend admin user name"
}
variable "admin_password" {
  type        = string
  default     = "P@$$w0rd1234!"
  description = "frontend admin password"
}
