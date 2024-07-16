#!/usr/bin/env bash

# Update package lists and install curl
sudo apt-get update
sudo apt-get install -y curl

# Check if Node.js is installed
if ! command -v node &> /dev/null; then
    echo "Node.js not found. Installing Node.js and npm..."
    curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
    sudo apt-get install -y nodejs
else
    echo "Node.js is already installed."
fi

# Check if npm is installed
if ! command -v npm &> /dev/null; then
    echo "npm not found. Installing npm..."
    sudo apt-get install -y npm
else
    echo "npm is already installed."
fi

# Verify Node.js and npm installation
echo "Node.js version:"
node --version
echo "npm version:"
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