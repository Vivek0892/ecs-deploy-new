module "network-prod" {
  source = "./modules/network"
  stage = "prod"
  project = var.project
  stack = var.stack
  az_count = var.az_count_prod
  vpc_cidr = var.vpc_cidr_prod
}
module "compute-prod" {
  source = "./modules/compute-prod"
  stage = "prod"
  depends_on = [module.network-prod.alb_security_group_ids]
  project = var.project
  stack = var.stack
  aws_region = var.aws_region
  image_repo_url = module.cicd.image_repo_url
  vpc_main_id = module.network-prod.vpc_main_id
  cw_log_group = "${var.project}-prod"
  fargate-task-service-role = var.fargate-task-service-role-prod
  aws_alb_listener_arn = module.network-prod.alb_listener_arn
  aws_alb_security_group_ids = module.network-prod.alb_security_group_ids
  aws_alb_trgp_blue_id = module.network-prod.alb_target_group_blue_id
  aws_alb_trgp_blue_name = module.network-prod.alb_target_group_blue_name
  aws_alb_trgp_green_id = module.network-prod.alb_target_group_green_id
  aws_alb_trgp_green_name = module.network-prod.alb_target_group_green_name
  aws_private_subnet_ids = module.network-prod.vpc_private_subnet_ids
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
  codedeploy_application_name = module.compute-prod.codedeploy_app_name
  codedeploy_deployment_group_name = module.compute-prod.codedeploy_deployment_group_name
}