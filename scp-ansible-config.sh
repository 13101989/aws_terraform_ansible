#!/bin/sh

scp -q -o StrictHostKeyChecking=no -i ec2-user-private-key.pem ansible.cfg ec2-user@3.65.218.255:/home/ec2-user/
scp -q -o StrictHostKeyChecking=no -i ec2-user-private-key.pem ansible-private-key.pem ec2-user@3.65.218.255:/home/ec2-user/
scp -q -o StrictHostKeyChecking=no -i ec2-user-private-key.pem wp-config.php.j2 ec2-user@3.65.218.255:/home/ec2-user/
