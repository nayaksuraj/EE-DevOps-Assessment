#!/bin/bash

yum update -y

sleep 5
echo "Install SSM-Agent"
sudo yum install -y https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm
sudo systemctl enable amazon-ssm-agent
sudo systemctl start amazon-ssm-agent

echo "Installing AWS CLI v2"
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo  ./aws/install -i /usr/local/aws-cli -b /usr/local/bin


sudo amazon-linux-extras install -y docker
systemctl enable docker
systemctl start docker
sudo usermod -aG docker ec2-user
sudo chkconfig docker on

docker --version


echo "Install Terraform"
sudo wget https://releases.hashicorp.com/terraform/${TERRAFORM_VER}/terraform_${TERRAFORM_VER}_linux_amd64.zip
sudo unzip terraform_${TERRAFORM_VER}_linux_amd64.zip
sudo mv terraform /usr/local/bin/
terraform version


sleep 5
echo "Install Ansible"
sudo wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
sudo yum install epel-release-latest-7.noarch.rpm
sudo amazon-linux-extras install ansible2
ansible --version