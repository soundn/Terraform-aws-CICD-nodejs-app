#!/bin/bash

# Update and install Node.js and Postgres client
apt-get update
apt-get install -y curl
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
apt-get install -y nodejs
apt-get install -y postgresql-client
