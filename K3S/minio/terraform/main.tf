module "mod-gitlab" {
  source = "./gitlab"
}

module "mod-harbor" {
  source = "./harbor"
}

output "gitlab_user_id" {
  value = module.mod-gitlab.user_id
}

output "gitlab_user_secret" {
  value = module.mod-gitlab.user_secret
  sensitive = true
}

output "harbor_user_id" {
  value = module.mod-harbor.user_id
}

output "harbor_user_secret" {
  value = module.mod-harbor.user_secret
  sensitive = true
}