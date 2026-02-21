module "ec2-instance-k8s" {
  source                = "./modules/ec2-instances-k8s"
  instance_config       = local.instances_list[each.key]
  key_pair_name         = local.key_pair_name
  image_path            = local.image_path
  processor             = local.processor
  global_tag            = local.global_tag
  instance_profile_name = module.instance_profile.instance_profile_name
  security_group_id     = module.sg-k8s.security_group_id
  for_each              = { for idx, instance in local.instances_list : idx => instance }
}

module "sg-k8s" {
  source     = "./modules/sg-k8s"
  vpc_name   = local.vpc_name
  global_tag = local.global_tag
}

module "instance_profile" {
  source    = "./modules/instance_profile"
  role_name = local.role_name
}