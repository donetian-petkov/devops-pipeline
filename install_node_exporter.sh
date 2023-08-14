#!/bin/bash

echo "Install Node Exporter"
wget https://github.com/prometheus/node_exporter/releases/download/v1.5.0/node_exporter-1.5.0.linux-amd64.tar.gz

echo "Export Node Exporter"
tar xzvf node_exporter-1.5.0.linux-amd64.tar.gz

echo "Navigate to the extracted folder"
cd node_exporter-1.5.0.linux-amd64/ || exit

echo "Run Node Exporter"
./node_exporter &> /tmp/node-exporter.log &