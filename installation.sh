#!/bin/bash

# Check if script is run as root
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

# Update package lists
sudo apt update

# Install necessary dependencies
sudo apt install -y jq lsof net-tools nginx docker-ce

# Create directory for DevOpsFetch
mkdir -p /opt/devopsfetch

# Copy the main script
cp devopsfetch.sh /opt/devopsfetch/devopsfetch.sh
echo

# Make the script executable
chmod +x /opt/devopsfetch/devopsfetch.sh

# Create a symlink to make the script accessible system-wide
ln -s /opt/devopsfetch/devopsfetch.sh /usr/local/bin/devopsfetch
echo

# Copy systemd service file
cp devopsfetch.service /etc/systemd/system/devopsfetch.service
echo
# Reload systemd, enable and start the service
sudo systemctl daemon-reload
sudo systemctl enable devopsfetch.service
sudo systemctl start devopsfetch.service
echo

echo "devopsfetch has been installed successfully!"
echo "You can now use it by running 'devopsfetch' followed by the appropriate flags."
echo "The monitoring service has also been set up and started."
