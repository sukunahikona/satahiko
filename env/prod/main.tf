# VPC
module "vpc" {
  source          = "../../modules/vpc"
  vpc_cidr_block  = var.vpc_cidr_block
  vpc_name        = var.vpc_name
  public-1a-cidr  = var.public-1a-cidr
  public-1a-name  = var.public-1a-name
  public-1c-cidr  = var.public-1c-cidr
  public-1c-name  = var.public-1c-name
  public-1d-cidr  = var.public-1d-cidr
  public-1d-name  = var.public-1d-name
  private-1a-cidr = var.private-1a-cidr
  private-1a-name = var.private-1a-name
  private-1c-cidr = var.private-1c-cidr
  private-1c-name = var.private-1c-name
  private-1d-cidr = var.private-1d-cidr
  private-1d-name = var.private-1d-name
}

module "route" {
  source                = "../../modules/route"
  igw-name              = var.igw-name
  eipa-name             = var.eipa-name
  eipc-name             = var.eipc-name
  eipd-name             = var.eipd-name
  ngwa-name             = var.ngwa-name
  ngwc-name             = var.ngwc-name
  ngwd-name             = var.ngwd-name
  vpc_id                = module.vpc.vpc_id
  aws_subnet_public_1a  = module.vpc.aws_subnet_public_1a
  aws_subnet_public_1c  = module.vpc.aws_subnet_public_1c
  aws_subnet_public_1d  = module.vpc.aws_subnet_public_1d
  aws_subnet_private_1a = module.vpc.aws_subnet_private_1a
  aws_subnet_private_1c = module.vpc.aws_subnet_private_1c
  aws_subnet_private_1d = module.vpc.aws_subnet_private_1d
}

module "sg" {
  source        = "../../modules/sg"
  sg-board-name = var.sg-board-name
  sg-alb-name   = var.sg-alb-name
  sg-ecs-name   = var.sg-ecs-name
  vpc_id        = module.vpc.vpc_id
}

module "keypair" {
  source        = "../../modules/keypair"
  key-pair-name = var.key-pair-name
}

module "ec2" {
  source               = "../../modules/ec2"
  key_pair_main_id     = module.keypair.key_pair_main_id
  aws_subnet_public_1a = module.vpc.aws_subnet_public_1a
  sg_board_id          = module.sg.sg_board_id
}

module "certificate" {
  source           = "../../modules/certificate"
  domain-name      = var.domain-name
  certificate-name = var.certificate-name
  zone-id          = var.zone-id
}

module "alb" {
  source               = "../../modules/alb"
  alb-name             = var.alb-name
  alb-tg-name          = var.alb-tg-name
  dns-domain-name      = var.dns-domain-name
  zone-id              = var.zone-id
  cert_arn             = module.certificate.cert_arn
  aws_subnet_public_1a = module.vpc.aws_subnet_public_1a
  aws_subnet_public_1c = module.vpc.aws_subnet_public_1c
  aws_subnet_public_1d = module.vpc.aws_subnet_public_1d
  sg_alb_id            = module.sg.sg_alb_id
  vpc_id               = module.vpc.vpc_id
}

module "ecr" {
  source         = "../../modules/ecr"
  ecr-name       = var.ecr-name
  aws-region     = var.aws-region
  container-name = var.container-name
}

module "iamrole" {
  source = "../../modules/iamrole"
}

module "ecs" {
  source                                 = "../../modules/ecs"
  ecs-base-name                          = var.ecs-base-name
  ecs_deploy_iam_role_arn                = module.iamrole.ecs_deploy_iam_role_arn
  alb_tg_main_arn                        = module.alb.alb_tg_main_arn
  aws_ecr_repository_main_repository_url = module.ecr.aws_ecr_repository_main_repository_url
  aws_subnet_private_1a                   = module.vpc.aws_subnet_private_1a
  aws_subnet_private_1c                   = module.vpc.aws_subnet_private_1c
  aws_subnet_private_1d                   = module.vpc.aws_subnet_private_1d
  sg_ecs_id                              = module.sg.sg_ecs_id
  aws_lb_listener_https_arn              = module.alb.aws_lb_listener_https_arn
}
