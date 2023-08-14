#!/bin/bash

echo "* Downloading Prometheus"
wget https://github.com/prometheus/prometheus/releases/download/v2.42.0/prometheus-2.42.0.linux-amd64.tar.gz

echo "* Extracting Prometheus"
tar xzvf prometheus-2.42.0.linux-amd64.tar.gz

echo "* Cding to the prometheus folder"
cd prometheus-2.42.0.linux-amd64

echo "* Starting Prometheus"
sudo ./prometheus --config.file prometheus.yml --web.enable-lifecycle 2>> /tmp/prometheus.log &
