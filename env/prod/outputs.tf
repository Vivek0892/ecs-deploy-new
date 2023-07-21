output "ecs_task_execution_role_arn_prod" {
  value = module.compute-prod.ecs_task_execution_role_arn
}

output "alb_address_prod" {
  value = module.network-prod.alb_address
}

output "source_repo_clone_url_http" {
  value = module.cicd.source_repo_clone_url_http
}
