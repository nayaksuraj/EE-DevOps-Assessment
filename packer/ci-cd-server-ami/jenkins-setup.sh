#!/bin/bash

sudo yum update -y

echo "Install git"
sudo yum update -y
sudo yum install wget unzip git -y
sleep 5

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
wget https://releases.hashicorp.com/terraform/${TERRAFORM_VER}/terraform_${TERRAFORM_VER}_linux_amd64.zip
unzip terraform_${TERRAFORM_VER}_linux_amd64.zip
mv terraform /usr/local/bin/
terraform version


echo "Install Jenkins stable release"
sudo yum remove -y java
sudo yum -y install java-1.8.0-openjdk

sleep 5
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins-ci.org/redhat/jenkins.repo --no-check-certificate
sudo rpm --import https://pkg.jenkins.io/redhat/jenkins.io.key

sleep 11
yum --showduplicates list jenkins | expand
sudo yum install -y jenkins-2.255-1.1
sleep 2
chkconfig jenkins on


echo "Configure Jenkins"
chmod +x /tmp/install-plugins.sh
bash /tmp/install-plugins.sh
service jenkins start


echo "SUCCESS! Installation succeeded!"