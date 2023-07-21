output "ecs_task_execution_role_arn_dev" {
  value = module.compute-dev.ecs_task_execution_role_arn
}

output "alb_address_dev" {
  value = module.network-dev.alb_address
}

output "source_repo_clone_url_http" {
  value = module.cicd.source_repo_clone_url_http
}