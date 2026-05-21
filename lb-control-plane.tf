module "k8s-control-plane-lb" {
  count           = tonumber(local.config.k8s_master_instance_count) > 0 ? 1 : 0
  source          = "./modules/tf_hetzner_lb"
  name = "lb-control-plane-${local.env}"
  network_id      = module.network.network_id
  lb_type = local.common_lb_type
  lb_location = local.common_location
  service_listen_port = local.common_service_listen_port
  service_destination_port = local.common_service_destination_port
  service_protocol = local.common_service_protocol
}
