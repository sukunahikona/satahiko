variable "rds-base-name" {}
variable "db-name" {}
variable "db-username" {}
variable "db-password" {}
variable "engine" {
  default = "postgres"
}
variable "engine-version" {
  default = "15.3"
}
variable "db-instance" {
  default = "db.t4g.micro"
}
variable "db-snapshot-name" {}
variable "aws_db_subnet_group_name" {}
variable "sg_rds_id" {}