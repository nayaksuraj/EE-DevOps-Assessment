#!/bin/bash

sudo yum update -y

echo "Install git"
sudo yum install -y git
sudo yum install -y wget
sudo yum install -y unzip


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