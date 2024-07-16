#!/usr/bin/env bash

# Update package lists and install curl
sudo apt-get update
sudo apt-get install -y curl

# Install Node.js and npm using NodeSource
curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
sudo apt-get install -y nodejs

# Verify Node.js and npm installation
node --version
npm --version

# Install pm2 which is a production process manager for Node.js with a built-in load balancer.
sudo npm install -g pm2

# Stop any instance of our application running currently
pm2 stop example_app || true

# Change directory into the folder where the application is downloaded
cd ExampleApplication/

# Install application dependencies
npm install

# Start the application with the process name example_app using pm2
pm2 start ./bin/www --name example_app