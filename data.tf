data "aws_ssm_parameter" "username" {
  name = "param.${var.env}.rds.USERNAME"
}

data "aws_ssm_parameter" "password" {
  name = "param.${var.env}.rds.PASSWORD"
}


