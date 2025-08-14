module "user" {
  source = "git::https://github.com/devopsprocloud/terraform-roboshop-app.git?ref=main"
  component_sg_id = data.aws_ssm_parameter.user_sg_id.value
  private_subnet_id = local.private_subnet_id
  iam_instance_profile = "EC2-Role-For-Shell-Script"
  tags = var.tags
  zone_name = var.zone_name
  rule_priority = 20
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  private_subnet_ids = local.private_subnet_ids
  app_alb_listener_arn = data.aws_ssm_parameter.app_alb_listener_arn.value
  app_version = var.app_version
}