#!/bin/bash

# Update the operating system
sudo apt-get update
sudo apt-get upgrade -y

# Install Apache2 with HTTP/2 support
sudo apt-get install -y apache2
sudo a2enmod http2
sudo systemctl restart apache2

# Create a simple HTML file
echo "<html><body><h1>Hello World from Server 2</h1></body></html>" | sudo tee /var/www/html/index.html

# Ensure proper permissions for the HTML file
sudo chmod 644 /var/www/html/index.html
sudo chown www-data:www-data /var/www/html/index.html
