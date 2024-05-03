module "mod-gitlab" {
  source = "./gitlab"
}

module "mod-rclone" {
  source = "./rclone"
}

output "gitlab_user_id" {
  value = module.mod-gitlab.user_id
}

output "gitlab_user_secret" {
  value = module.mod-gitlab.user_secret
  sensitive = true
}

output "rclone_user_id" {
  value = module.mod-rclone.user_id
}

output "rclone_user_secret" {
  value = module.mod-rclone.user_secret
  sensitive = true
}