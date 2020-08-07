#!/usr/bin/env bash
#
# Going to try to install some of the things that I have in brew.sh, but there may be some packages that I'll generally
# care less about having on Linux systems.
# 
set -e

echo "Installing a bunch of packages, will likely require permissions escalation"

sudo apt-get update

sudo apt-get install -y \
    curl \
    git \
    xclip \
    apt-transport-https \
    ca-certificates \
    gnupg-agent \
    software-properties-common

# VS Code
wget https://go.microsoft.com/fwlink/?LinkID=760868 -O code.deb
sudo dpkg -i code.deb
sudo apt-get install -f
rm code.deb

# Chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
sudo apt-get install -f
rm google-chrome-stable_current_amd64.deb

# Docker
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
sudo add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/debian \
    $(lsb_release -cs) \
    stable"

sudo apt-get update
sudo apt-get install -y \
	docker-ce \
	docker-ce-cli \
	containerd.io

sudo -k
