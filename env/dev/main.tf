module "network-dev" {
  source = "./modules/network"
  stage = "dev"
  project = var.project
  stack = var.stack
  az_count = var.az_count_dev
  vpc_cidr = var.vpc_cidr_dev
}
module "compute-dev" {
  source = "./modules/compute"
  stage = "dev"
  depends_on = [module.network-dev.alb_security_group_ids]
  project = var.project
  stack = var.stack
  aws_region = var.aws_region
  image_repo_url = module.cicd.image_repo_url
  fargate-task-service-role = var.fargate-task-service-role-dev
  aws_alb_trgp_id = module.network-dev.alb_target_group_id
  aws_private_subnet_ids = module.network-dev.vpc_private_subnet_ids
  alb_security_group_ids = module.network-dev.alb_security_group_ids
  vpc_main_id = module.network-dev.vpc_main_id
  cw_log_group = "${var.project}-dev"
}

# Shared CI/CD infrastructure
module "cicd" {
  source = "./modules/cicd"
  project = var.project
  stack = var.stack
  aws_region = var.aws_region
  image_repo_name = var.image_repo_name
  source_repo_branch = var.source_repo_branch
  source_repo_name = var.source_repo_name
  family = var.family
  ecs_cluster_name_dev = module.compute-dev.ecs_cluster_name
  ecs_service_name_dev = module.compute-dev.ecs_service_name
}