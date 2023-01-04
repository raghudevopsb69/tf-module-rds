resource "aws_db_subnet_group" "rds" {
  name       = "${var.env}-rds"
  subnet_ids = local.app_subnets_ids

  tags = {
    Name = "${var.env}-rds"
  }
}

resource "aws_rds_cluster" "rds" {
  cluster_identifier      = "${var.env}-rds"
  engine                  = var.engine
  engine_version          = var.engine_version
  database_name           = var.dbname
  master_username         = data.aws_ssm_parameter.username.value
  master_password         = data.aws_ssm_parameter.password.value
  backup_retention_period = var.backup_retention_period
  preferred_backup_window = var.preferred_backup_window
  skip_final_snapshot     = var.skip_final_snapshot
  storage_encrypted       = var.storage_encrypted
  kms_key_id              = var.kms_key_id
  vpc_security_group_ids  = [aws_security_group.allow_rds.id]
  db_subnet_group_name    = aws_db_subnet_group.rds.name
}

