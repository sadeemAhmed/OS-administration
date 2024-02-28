#!/bin/bash

# Get the username as input

read -p "Enter the username: " username

# Search for user activities in the auth log and save to a file

grep "$username" /var/log/auth.log > ~/ActivitiesLog.txt

