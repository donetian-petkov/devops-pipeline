# Use a base image that provides the operating system you want
FROM ubuntu:latest

# Install Git
RUN apt-get update && \
    apt-get install -y git && \
    apt-get clean

# Set your desired working directory
WORKDIR ./
