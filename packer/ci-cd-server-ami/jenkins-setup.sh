#!/bin/bash


echo "Install git"
sudo yum update -y
sudo yum install wget unzip git -y
sudo amazon-linux-extras install epel -y
sudo yum-config-manager --enable epel
sleep 5

echo "Install Jenkins stable release"
sudo yum install java-1.8.0-openjdk-devel -y
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins-ci.org/redhat-stable/jenkins.repo --no-check-certificate
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key

yum --showduplicates list jenkins | expand
sudo yum install -y jenkins-2.319.1-1.1
chkconfig jenkins on


echo "Configure Jenkins"
mkdir -p /var/lib/jenkins/init.groovy.d
mv /tmp/basic-security.groovy /var/lib/jenkins/init.groovy.d/basic-security.groovy
mv /tmp/jenkins /etc/sysconfig/jenkins
sudo chmod +x /tmp/install-plugins.sh
sudo bash /tmp/install-plugins.sh

chown -R jenkins:jenkins /var/lib/jenkins
chmod -R 777 /var/lib/jenkins

sleep 5
sudo systemctl daemon-reload
sudo systemctl start jenkins
sudo systemctl status jenkins


echo "SUCCESS! Installation succeeded!"