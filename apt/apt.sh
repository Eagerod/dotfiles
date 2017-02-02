#!/usr/bin/env bash
#
# Going to try to install some of the things that I have in brew.sh, but there may be some packages that I'll generally
# care less about having on Linux systems.
# 

echo "Installing a bunch of packages, will likely require permissions escalation"

# Repositories where all these different packages lie.
sudo add-apt-repository "deb https://cli-assets.heroku.com/branches/stable/apt ./"

curl -sL https://cli-assets.heroku.com/apt/release.key | sudo apt-key add -

sudo apt-get update

sudo apt-get install git
sudo apt-get install heroku
sudo apt-get install nodejs-legacy
sudo apt-get install mongodb
sudo apt-get install texlive-full
sudo apt-get install xclip

sudo apt-get install sublime-text

# http://stackoverflow.com/questions/18130164
sudo ln -s `which nodejs` /usr/bin/node

# And then the odd thing that isn't properly managed in apt.
# Might as well just have them all in the same installer script.
mkdir ngrok-unzip
cd ngrok-unzip
wget https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip
unzip ngrok-stable-linux-amd64.zip
mv ngrok /usr/local/bin/
cd ..
rm -rf ngrok-unzip

sudo -k
