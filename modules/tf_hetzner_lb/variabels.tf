variable "name" {
  type    = string
  default = ""
}

variable "lb_type" {
  type    = string
  default = "lb11"
}

variable "lb_location" {
  type    = string
  default = "nbg1"
}

variable "service_listen_port" {
  type    = string
  default = "443"
}
variable "service_destination_port" {
  type    = string
  default = "80"
}
variable "service_protocol" {
  type    = string
  default = "tcp"
}

variable "network_id" {
  type = any
}
