#!/usr/bin/env bash
#
# Going to try to install some of the things that I have in brew.sh, but there may be some packages that I'll generally
# care less about having on Linux systems.
# 
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
DOTFILES_DIR="$(dirname "$SCRIPT_DIR")"

. "$DOTFILES_DIR/utils.sh"

echo "Installing a bunch of packages, will likely require permissions escalation"

NEOFETCH_VERSION=7.1.0
TELA_VERSION=2020-06-25

sudo apt-get update
sudo apt-get install -y \
    software-properties-common \
    apt-transport-https
sudo apt-get update

sudo apt-get install -y \
    ca-certificates \
    curl \
    dnsutils \
    git \
    gnupg-agent \
    iputils-ping \
    libappindicator1 \
    make \
    net-tools \
    openssh-server \
    terminator \
    traceroute \
    vim \
    vnc4server \
    xclip \
    xz-utils

# VS Code
if ! type code; then 
    wget https://go.microsoft.com/fwlink/?LinkID=760868 -O code.deb
    sudo dpkg -i code.deb
    sudo apt-get install -f
    rm code.deb
else
    echo >&2 "VS Code already installed."
fi

# Chrome
if ! type google-chrome; then
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    sudo dpkg -i google-chrome-stable_current_amd64.deb
    sudo apt-get install -f
    rm google-chrome-stable_current_amd64.deb
else
    echo >&2 "Chrome already installed."
fi

# neofetch
if ! type neofetch; then
    curl -fsSL "https://github.com/dylanaraps/neofetch/archive/$NEOFETCH_VERSION.zip" -o neofetch.zip
    unzip -q neofetch.zip
    sudo PREFIX=/usr/local make -C neofetch-* install
else
    echo >&2 "Neofetch already installed."
fi

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

# Themeing
sudo apt-get install -y \
    sddm \
    xorg \
    arc-theme \
    gtk3.0 \
    plasma-desktop \
    dolphin \
    latte-dock \
    tasksel \
    qt5-style-kvantum \
    qt5-style-kvantum-themes

temp_dir="$(mktemp -d)"
cd "$temp_dir"
echo "Running in $temp_dir"


git clone https://github.com/vinceliuice/Layan-kde
sudo ./Layan-kde/install.sh

curl -fsSL "https://github.com/vinceliuice/Tela-icon-theme/releases/download/$TELA_VERSION/Tela-icon-theme-$TELA_VERSION.deb" -o tela.deb
sudo dpkg -i tela.deb
sudo apt-get install -f

rm -rf "$temp_dir"

sudo apt-get purge -y \
    xfce4 \
    xfce4-notifyd \
    xfce4-session \
    xfce4-terminal \
    xterm

sudo apt autoremove -y

create_symlink_and_backup /etc/X11/xinit/xinitrc ~/.xinitrc

kde_wm_n=$(echo | update-alternatives --config x-session-manager | grep startkde | awk '{print $1}')
if [ "$kde_wm_n" != "*" ]; then
	echo $kde_wm_n | sudo update-alternatives --config x-session-manager
fi

sudo sh -c "sudo cat > /etc/systemd/system/vncserver.service" <<'EOF'
[Unit]
Description=VNC Server Service
After=syslog.target network.target

[Service]
Type=simple
ExecStartPre=/bin/sh -c '/usr/bin/vncserver -kill :0 || :'
ExecStart=/sbin/runuser -l aleem -c '/usr/bin/vncserver :0 -localhost no -fg'

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl daemon-reload
sudo systemctl enable vncserver
sudo systemctl start vncserver

echo >&2 "If this is the first time running, the window manager has been reintalled."
echo >&2 "You will have to log out and log back in to use KDE."

sudo -k
