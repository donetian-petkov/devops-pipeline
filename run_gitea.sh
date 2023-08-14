#!/bin/bash

  mkdir source_repo || true
  cd source_repo || exit

  git clone https://github.com/shekeriev/fun-facts
  git remote add origin http://192.168.99.102:3000/donetian/fun-facts

  git commit -m "Initial Commit"
  git push -u origin main
