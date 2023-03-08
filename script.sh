#!/bin/bash

# Create meal-planner directory and move into it
mkdir meal-planner
cd meal-planner

# Initialize git and clone the meal-planner-application repository
git init
git clone https://github.com/Ejegz/meal-planner-application.git

# Move into the cloned repository and install dependencies
cd meal-planner-application
npm i

# Start the application in the background with nohup
nohup npm run start > app.log 2>&1 &

# Move to Nginx sites-available directory, remove the default file, and copy the new configuration file
cd /etc/nginx/sites-available
sudo rm -rf default
cd ~/meal-app && cp default /etc/nginx/sites-available

