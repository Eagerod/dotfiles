echo "Updating file associations..."

# Basically anything that would open with a plain text editor anyways.
sudo sed -i'' -e 's/gedit.desktop/sublime-text-2.desktop/' /etc/gnome/defaults.list

# Odds and ends that have been annoying.
sudo sed -i'' -e 's_text/xml=.*_text/xml=sublime-text-2.desktop_' /etc/gnome/defaults.list
sudo sed -i'' -e 's_text/x-comma-separated-values=.*_text/x-comma-separated-values=sublime-text-2.desktop_' /etc/gnome/defaults.list
sudo sed -i'' -e 's_text/comma-separated-values=.*_text/comma-separated-values=sublime-text-2.desktop_' /etc/gnome/defaults.list 
