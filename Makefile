.PHONY: env-plan env-up env-down clean-env-files clean-terraform-files

env-plan:
	terraform init
	terraform fmt
	terraform validate
	terraform plan

env-up:	
	terraform apply --auto-approve
	terraform output -raw user_to_ansible_private_key > user-to-ansible-private-key.pem
	terraform output -raw ansible_to_wordpress_private_key > ansible-to-wordpress-private-key.pem
	chmod 400 user-to-ansible-private-key.pem
	chmod 400 ansible-to-wordpress-private-key.pem

	printf "#!/bin/sh\n\n" > ssh-to-ansible.sh
	printf "ssh -i user-to-ansible-private-key.pem ec2-user@" >> ssh-to-ansible.sh
	terraform output -raw ansible_public_ip >> ssh-to-ansible.sh
	chmod 750 ssh-to-ansible.sh

	printf "#!/bin/sh\n\n" > ssh-to-wordpress.sh
	printf "ssh -i ansible-to-wordpress-private-key.pem ec2-user@" >> ssh-to-wordpress.sh
	terraform output -raw wordpress_public_ip >> ssh-to-wordpress.sh
	chmod 750 ssh-to-wordpress.sh

	printf "[defaults]\ninventory = inventory\n" > ansible.cfg
	printf "private_key_file = /home/ec2-user/ansible-to-wordpress-private-key.pem" >> ansible.cfg

	printf "[nodes]\n" > inventory
	terraform output -raw wordpress_public_ip >> inventory

	printf "#!/bin/sh\n\n" > scp-ansible-config.sh
	printf "scp -q -o StrictHostKeyChecking=no -i user-to-ansible-private-key.pem ansible-to-wordpress-private-key.pem ssh-to-wordpress.sh ansible.cfg inventory ./playbooks/* ec2-user@" >> scp-ansible-config.sh
	terraform output -raw ansible_public_ip >> scp-ansible-config.sh
	printf ":/home/ec2-user/\n" >> scp-ansible-config.sh
	chmod 750 scp-ansible-config.sh
	./scp-ansible-config.sh

env-down:
	terraform destroy --auto-approve
	make clean-env-files
	make clean-terraform-files

clean-env-files:
	rm -rf user-to-ansible-private-key.pem ansible-to-wordpress-private-key.pem ansible.cfg inventory ssh.sh scp-ansible-config.sh ssh-to-ansible.sh ssh-to-wordpress.sh

clean-terraform-files:
	rm -rf .terraform
	rm -rf .terraform.lock.hcl
