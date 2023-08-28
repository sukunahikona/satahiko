locals {
    ts = formatdate("YYYYMMDDhhmmss", timestamp())
}

#--------------------------------------------------------------
# RDS
#--------------------------------------------------------------

resource "aws_db_instance" "main" {
  identifier              = "${var.rds-base-name}-instance"
  db_name                 = var.db-name
  allocated_storage       = 10
  storage_type            = "gp2"
  engine                  = var.engine
  engine_version          = var.engine-version
  instance_class          = var.db-instance
  db_subnet_group_name    = var.aws_db_subnet_group_name
  password                = var.db-password
  username                = var.db-username
  backup_retention_period = 0
  multi_az                = false
  #  multi_az                   = true
  auto_minor_version_upgrade = false
  deletion_protection        = false
  skip_final_snapshot        = false
  final_snapshot_identifier  = "${var.rds-base-name}-snapshot-${local.ts}"
  snapshot_identifier        = var.db-snapshot-name
  lifecycle {
    ignore_changes = [snapshot_identifier]
  }

  vpc_security_group_ids = [var.sg_rds_id]

  tags = {
    Name = "${var.rds-base-name}"
  }
}
