#!/bin/bash
  apt-get update
  apt-get install -y git

  git config --global user.email "you@example.com"
  git config --global user.name "Your Name"
  git config --global --add safe.directory /var/www/html

  git init
  git checkout -b main
  git add .
  git commit -m "Initial commit"

  git remote add origin http://192.168.111.202:3000/donetian/supercalc.git
  git push -u origin main