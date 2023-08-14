#!/bin/bash

  mkdir source_repo || true
  cd source_repo || exit

  git clone http://192.168.111.202:3000/myadminuser/supercalc 

  git commit -m "Initial Commit"
  git push -u origin main
