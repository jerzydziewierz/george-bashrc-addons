# this prepares a fresh ubuntu to work for me
DEBIAN_FRONTEND=noninteractive
cd ~
mkdir -p prog git prog/git 
pushd prog
apt update  
apt upgrade -y -force-confnew
# CLI-only tools
apt install -y sshfs git make screen p7zip-full curl wget coreutils sed build-essential python3 python3-pip gcc-10 g++-10 sysstat
# if needed: gcc-11
sudo add-apt-repository -y ppa:ubuntu-toolchain-r/test
apt install -y gcc-11 g++-11

# desktop tools
apt install -y xclock kate krusader qalculate vlc shutter fsearch
apt install -y ffmpeg gimp inkscape gparted
apt install -y gnome-tweak-tool gnome-shell-extensions
# fsearch filesystem indexing and search



# docker
apt install -y apache2-utils
sudo curl -fsSL https://get.docker.com |bash
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# nvidia CUDA along with the drivers
# 
# wget -c https://developer.nvidia.com/cuda-downloads?target_os=Linux&target_arch=x86_64&Distribution=Ubuntu&target_version=20.04&target_type=deb_local


# apt install zoxide
# after this, one needs to add "eval "$(zoxide init bash)"" to .bashrc
curl -sS https://webinstall.dev/zoxide | bash
echo 'eval $(zoxide init bash)' >> ~/.bashrc

# apt install fzf
# install fzf with git :
cd ~
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --all



snap install clion 
snap install pycharm-professional --classic


# ::: go to `prog`
mkdir -p ~/prog
pushd prog


# install terminator from source
# - in ~/prog
git clone git@github.com:gnome-terminator/terminator.git
pushd terminator
python3 -m pip install .
popd

# install other terminal emulators to check

apt install kitty
apt install tilix


## to install:
# [ ] xnview, 
# [ ] gimp, 
# [ ] qalculate-qt
# [ ] typora, 
# [ ] obsidian
# [ ] FZF and [x] zoxide
# [ ] sshfs
# [ ] btop
# [ ] zfs tools
# [ ] netstat
# [ ] iostat
# [ ] gping
# [ ] miniconda and [ ] mamba
# [ ] jupyter notebook
# [ ] links to reymonte, using ssh and sshfs

# ::: xnView
# - in ~/prog
wget https://download.xnview.com/XnViewMP-linux-x64.deb
apt install -y ./XnViewMP-linux-x64.deb

# ::: miniconda, mamba, python and basic tooling
# - in ~/prog
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
chmod +x Miniconda3-latest-Linux-x86_64.sh
./Miniconda3-latest-Linux-x86_64.sh -b -u
/root/miniconda3/bin/conda init
source ~/.bashrc 
conda config --add channels conda-forge
conda create -y -n jupyter
conda activate jupyter
conda install -y mamba 
mamba install -y 
alias mambao="mamba install --use-index-cache -y --channel conda-forge"
python -m pip install -U git+https://github.com/jerzydziewierz/mict.git#egg=mict
mambao jupyter ipython plotly numpy pandas cryptography jax python-kaleido tqdm watermark pymc3
python -m pip install kaleido


# ::: flatpak is needed for gimp
sudo apt install -y flatpak
flatpak install -y https://flathub.org/repo/appstream/org.gimp.GIMP.flatpakref


# ::: (deprecated) gping from apt 
echo "deb http://packages.azlux.fr/debian/ buster main" | sudo tee /etc/apt/sources.list.d/azlux.list
wget -qO - https://azlux.fr/repo.gpg.key | sudo apt-key add -
sudo apt update
sudo apt install -y gping

# ::: rust 
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y


# ::: gping from sources
# - in ~/prog
git clone https://github.com/orf/gping.git
cd gping
cargo build --release 
cd gping 
cargo install --path .




# ::: Typora
# - in ~/prog
https://download.typora.io/linux/typora_1.1.5_amd64.deb
apt install ./typora_1.1.5_amd64.deb


# ::: Obsidian
# # they release often
# - in ~/prog
gnome-www-browser https://github.com/obsidianmd/obsidian-releases/releases/latest/


# ============= Font awesome for terminal
# see https://github.com/gabrielelana/awesome-terminal-fonts
# alternate: https://github.com/ryanoasis/nerd-fonts
# - in ~/prog
git clone git@github.com:gabrielelana/awesome-terminal-fonts.git
awesome-terminal-fonts/install.sh

# === download Inconsolata and install
# ::: Inconsolata font
mkdir -p inconsolata-source
pushd inconsolata-source 
wget https://fonts.google.com/download?family=Inconsolata -o inconsolata.zip
# mv 'download?family=Inconsolata' inconsolata.zip
cp Inconsolata-VariableFont_wdth,wght.ttf ~/.fonts/
fc-cache -fv ~/.fonts
popd 

# == btop from source

git clone https://github.com/aristocratos/btop.git
cd btop
make
make install

# btop from release 
# https://github.com/aristocratos/btop/releases/

# == reg -- custom docker registry access tool
# fromh ttps://github.com/genuinetools/reg/releases
# Export the sha256sum for verification.
export REG_SHA256="ade837fc5224acd8c34732bf54a94f579b47851cc6a7fd5899a98386b782e228"
# Download and check the sha256sum.
curl -fSL "https://github.com/genuinetools/reg/releases/download/v0.16.1/reg-linux-amd64" -o "/usr/local/bin/reg" \
	&& echo "${REG_SHA256}  /usr/local/bin/reg" | sha256sum -c - \
	&& chmod a+x "/usr/local/bin/reg"
echo "reg installed!"
# Run it!
reg -h

# ::: cleanup
apt autoremove


=== script for .screenrc 
# startup_message off
# defscrollback 99999
# # escape ^za
# # exec echo "SCREEN session -- note that the escape character is ^z"
# hardstaus on
# hardstatus firstline
# hardstatus string "tp8+screen %S | %= | %{= BW}escape char is ctrl-a%{= dd}"

=== increase swap 
# create empty file
dd if=/dev/zero of=/swapfile bs=1G count=16
# bake the swap file
mkswap /swapfile
# Add this line to /etc/fstab
/swapfile swap swap sw 0 0
# change premissions
chmod 0600 /swapfile
# activate 
swapon /swapfile
# verify
cat /proc/swaps

# == decrease keepalive interval to make the ssh connection more stable
# see https://patrickmn.com/aside/how-to-keep-alive-ssh-sessions/
# on the client
echo "Host *" >> ~/.ssh/config 
echo "    ServerAliveInterval 30" >> ~/.ssh/config
echo "    ServerAliveCountMax 20" >> ~/.ssh/config 
# on the host
echo "ClientAliveInterval 30" >> /etc/ssh/sshd_config
echo "ClientAliveCountMax 20" >> /etc/ssh/sshd_config




# == create SSH key
cd ~/.ssh
ssh-keygen -t ed25519
cat ~/.ssh/id_ed25519.pub
eval "$(ssh-agent -s)"
ssh-add

# this repo:
# git@github.com:jerzydziewierz/george-bashrc-addons.git

# === run jupyter notebook via ssh
# screen -S jupyter
# jupyter notebook --allow-root --no-browser --port 1234
# ssh -X -L 1234:localhost:1234 root@host
