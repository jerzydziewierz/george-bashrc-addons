#!/bin/bash

# run using:
# curl https://raw.githubusercontent.com/jerzydziewierz/george-bashrc-addons/main/ubuntu-prep/ubuntu-preparator-script-20220508.sh | bash



# this prepares fresh ubuntu to work for me
# intended for non-gui machines
# intended for remote consoles
# intended for automatic unattended Installation
# multi-run capable (nothing bad happens if ran more than once)


export DEBIAN_FRONTEND=noninteractive
export DEBIAN_PRIORITY=critical

# == create SSH key
if [[ ! -f ~/.ssh/id_ed25519.pub ]];
  then
    echo "creating new local ssh key"
        pushd ~/.ssh
        yes "" | ssh-keygen -t ed25519
        echo "-----------------------"
        cat ~/.ssh/id_ed25519.pub
        echo "-----------------------"
        eval "$(ssh-agent -s)"
        ssh-add
        popd # ~/.ssh
      echo "created new local ssh key".
  else
    echo "ssh key already exists"
fi




# allow github as known
# to get key: ssh-scan -t rsa github.com
if ! grep github.com ~/.ssh/known_hosts > /dev/null
then
     echo "github.com ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAq2A7hRGmdnm9tUDbO9IDSwBK6TbQa+PXYPCPy6rbTrTtw7PHkccKrpp0yVhp5HdEIcKr6pLlVDBfOLX9QUsyCOV0wzfjIJNlGEYsdlLJizHhbn2mUjvSAHQqZETYP81eFzLQNnPHt4EVVUh7VfDESU84KezmD5QlWpXLmvU31/yMf+Se8xhHTvKSCZIFImWwoG6mbUoWf9nzpIoaSjB+weqqUUmpaaasXVal72J+UX2B+2RPW3RcT0eOzQgqlJL3RKrTJvdsjE3JEAvGq3lGHSZXy28G3skua2SmVi/w4yCE6gbODqnTWlg7+wC604ydGXA8VJiS5ap43JXiUFFAaQ==" >> ~/.ssh/known_hosts
# Allow bitbucket as known
     echo "bitbucket.org ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAubiN81eDcafrgMeLzaFPsw2kNvEcqTKl/VqLat/MaB33pZy0y3rJZtnqwR2qOOvbwKZYKiEO1O6VqNEBxKvJJelCq0dTXWT5pbO2gDXC6h6QDXCaHo6pOHGPUy+YBaGQRGuSusMEASYiWunYN0vCAI8QaXnWMXNMdFP3jHAJH0eDsoiGnLPBlBp4TNm6rYI74nMzgz3B9IikW4WVK+dc8KZJZWYjAuORU3jc1c/NPskD2ASinf8v3xnfXeukU0sJ5N6m5E8VLjObPEO+mN2t/FZTMZLiFqPWc/ALSqnMnnhwrNi2rbfg/rd/IpL8Le3pSBne8+seeFVBoGqzHM9yXw==" >> ~/.ssh/known_hosts
fi

# == decrease keepalive interval to make the ssh connection more stable
# see https://patrickmn.com/aside/how-to-keep-alive-ssh-sessions/
# on the client
echo "Host *" >> ~/.ssh/config
echo "    ServerAliveInterval 30" >> ~/.ssh/config
echo "    ServerAliveCountMax 20" >> ~/.ssh/config
echo "    Compression yes" >> ~/.ssh/config
echo "    CompressionLevel 6" >> ~/.ssh/config
# on the host
echo "ClientAliveInterval 30" >> /etc/ssh/sshd_config
echo "ClientAliveCountMax 20" >> /etc/ssh/sshd_config
echo "Compression yes" >> /etc/ssh/sshd_config

cd ~
mkdir -p prog git prog/git
pushd prog
apt update >> /dev/null

# for non-interactive upgrades, the "new configuration file" is sometimes problematic.

apt-get -qy update >> /dev/null
apt-get -qy -o "Dpkg::Options::=--force-confdef" -o "Dpkg::Options::=--force-confold" upgrade  >> /dev/null
apt-get -qy autoremove >> /dev/null
apt-get -qy autoclean >> /dev/null



# CLI-only tools
echo "installing CLI-only tools"
apt install -y sshfs openssh-server git make screen p7zip-full curl wget coreutils sed build-essential python3 python3-pip gcc-10 g++-10 sysstat tldr ncdu >> /dev/null

apt install -y sshfs

# if needed: gcc-11
echo "installing gcc-11"
sudo add-apt-repository -y ppa:ubuntu-toolchain-r/test  >> /dev/null
apt install -y gcc-11 g++-11 >> /dev/null

apt install -y lnav ncdu pv tldr

# xsel is a command line utility for copying and pasting text from the X11 clipboard.
apt install -y xsel


# apt install zoxide
# after this, one needs to add "eval "$(zoxide init bash)"" to .bashrc
curl -sS https://webinstall.dev/zoxide | bash
echo 'eval $(zoxide init bash)' >> ~/.bashrc

# apt install fzf
# install fzf with git :
cd ~

# !! On the first run, asks for github key
if [[ ! -d ~/.fzf ]];
  then
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install --all
    source ~/.bashrc  # bash
  else
    echo "fzf already installed"
fi



# install george's bashrc addons
if [[ ! -d ~/git/george-bashrc-addons ]];
  then
    cd ~/git
    git clone git@github.com:jerzydziewierz/george-bashrc-addons.git
    pushd george-bashrc-addons
    cp secrets.template.sh secrets.sh
    popd
    echo 'pushd ~/git/george-bashrc-addons >> /dev/null' >> ~/.bashrc
    echo 'george-bashrc-addons.sh' >> ~/.bashrc
    echo 'popd >> /dev/null' >> ~/.bashrc
    source ~/.bashrc
    echo "george's bashrc addons installed"
  else
    echo "george's bashrc addons already installed"
fi

# internet general speed test with OOKLA
curl -s https://install.speedtest.net/app/cli/install.deb.sh | sudo bash
sudo apt-get install speedtest
yes "YES" | speedtest

# point to point lag test with lagscope
if [[ ! -d ~/git/lagscope ]];
  then
  pushd ~/git
  git clone https://github.com/microsoft/lagscope.git
  pushd lagscope
  ./do-cmake.sh build
  sudo ./do-cmake.sh install
  popd # lagscope
  popd # git
  echo "lagscope installed"
else
  echo "lagscope already installed"
fi

# ::: rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
# ::: exa

git clone https://github.com/ogham/exa
pushd exa
cargo install --path .
popd



snap install clion --classic

# increase inotify limit
echo fs.inotify.max_user_watches=65536 | sudo tee -a /etc/sysctl.conf
sudo sysctl -p

# install neptune
pip install neptune-client
pip install neptune-notebooks

# if rust/cargo is available
cargo install bottom
argo install --features nvidia --git https://github.com/bvaisvil/zenith.git
