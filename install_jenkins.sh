#!/bin/bash

echo "* Add and import the repository key"
sudo wget https://pkg.jenkins.io/redhat/jenkins.repo -O /etc/yum.repos.d/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key

echo "* Update repositories and install components"
sudo dnf update
sudo dnf install -y java-17-openjdk jenkins git

echo "* Start the service"
sudo systemctl enable --now jenkins

echo "* Adjust the firewall"
firewall-cmd --permanent --add-port=8080/tcp
firewall-cmd --reload

echo "* admin password is:"
cat /var/lib/jenkins/secrets/initialAdminPassword
