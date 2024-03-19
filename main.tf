# Configure Terraform settings
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  cloud {
    organization = "my-skillab"

    workspaces {
      name = "aws-terraform-ansible"
    }
  }
}


# Configure AWS provider settings
provider "aws" {
  region = var.region
}


module "key_pair_ansible" {
  source = "./modules/ansible/key-pair"

  key_name = var.key_name_user_to_ansible
}

module "key_pair_wordpress" {
  source = "./modules/wordpress/key-pair"

  key_name = var.key_name_ansible_to_wordpress
}


module "security_group_ansible" {
  source = "./modules/ansible/security-group"

  ssh_access_cidr = var.ssh_access_cidr
}

module "security_group_wordpress" {
  source = "./modules/wordpress/security-group"

  ssh_access_cidr = var.ssh_access_cidr
  web_access_cidr = var.web_access_cidr
}


module "ec2_instance_ansible" {
  source = "./modules/ansible/ec2-instance"

  instance_type   = var.instance_type
  ami_id          = var.ami_id
  key_name        = module.key_pair_ansible.key_name
  security_groups = [module.security_group_ansible.security_group_name]
}

module "ec2_instance_wordpress" {
  source = "./modules/wordpress/ec2-instance"

  instance_type   = var.instance_type
  ami_id          = var.ami_id
  key_name        = module.key_pair_wordpress.key_name
  security_groups = [module.security_group_wordpress.security_group_name]
}


module "volume_wordpress" {
  source = "./modules/wordpress/volume"

  availability_zone = module.ec2_instance_wordpress.availability_zone
  instance_id       = module.ec2_instance_wordpress.instance_id
}

output "user_to_ansible_private_key" {
  value     = module.key_pair_ansible.user_to_ansible_private_key
  sensitive = true
}

output "ansible_to_wordpress_private_key" {
  value     = module.key_pair_wordpress.ansible_to_wordpress_private_key
  sensitive = true
}

output "ansible_public_ip" {
  value = module.ec2_instance_ansible.ansible_public_ip
}

output "wordpress_public_ip" {
  value = module.ec2_instance_wordpress.wordpress_public_ip
}